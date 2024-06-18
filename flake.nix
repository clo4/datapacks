{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      packages = let
        callDataPack = path: args: pkgs.callPackage path ({inherit buildDataPack;} // args);

        buildDataPack = args:
          pkgs.stdenvNoCC.mkDerivation (args
            // {
              version = args.version;
              nativeBuildInputs = [pkgs.zip pkgs.unzip];

              buildPhase = ''
                runHook preBuild
                # I don't love this but for most people I think they might assume
                # something is weird or wrong if the modification time for all the files
                # in the zip is 1970. This is for Minecraft players, not Nix developers
                touch **
                zip -r datapack.zip $zip
                runHook postBuild
              '';

              doCheck = true;
              checkPhase = ''
                set -eo pipefail

                # The file should exist and be a valid zip file
                zip -T datapack.zip

                # As for the contents, the only thing that really matters is that there's
                # a pack.mcmeta. If I've fucked up and it's invalid, that's on me.
                unzip datapack.zip -d test-output
                test -f test-output/pack.mcmeta
              '';

              installPhase = ''
                mkdir -p $out/datapacks
                mv datapack.zip $out/datapacks/$pname+v$version+mc$minMinecraftVersion-$maxMinecraftVersion.zip
              '';
            });

        # Based on the definition of symlinkJoin but specific to merging datapacks.
        # This makes releasing and testing a bit simpler
        joinDataPacks = args_ @ {
          name,
          packages,
          ...
        }: let
          args = removeAttrs args_ ["name"] // {passAsFile = ["packages"];};
        in
          pkgs.runCommand name args ''
            mkdir -p $out/datapacks
            for path in $(cat $packagesPath); do
              cp $path/datapacks/* $out/datapacks
            done
          '';
      in rec {
        afk = callDataPack ./afk {};
        afk-sleep = callDataPack ./afk-sleep {};
        afk-message = callDataPack ./afk-message {};
        afk-dim-names = callDataPack ./afk-dim-names {};
        pause-day-cycle = callDataPack ./pause-day-cycle {};
        chickenfix = callDataPack ./chickenfix {};

        # Check if this is right
        default = all;
        all = joinDataPacks {
          name = "clo4-datapacks";
          packages = [
            afk
            afk-sleep
            afk-message
            afk-dim-names
            pause-day-cycle
            chickenfix
          ];
        };
      };
    });
}
