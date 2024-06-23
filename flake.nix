{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mcmeta-summary = {
      url = "github:misode/mcmeta/summary";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    mcmeta-summary,
  }:
    {
      overlays.default = final: prev: let
        builder = final.callPackage (import ./nix/builder.nix) {
          minecraftVersionsSummary = builtins.fromJSON (builtins.readFile "${mcmeta-summary}/versions/data.json");
        };
      in {
        inherit (builder) buildDataPack;
      };
      templates = {
        default = {
          description = "Single data pack in the root of the repository";
          path = ./nix/templates/default;
        };
        monorepo = {
          description = "Multiple data packs in subdirectories";
          path = ./nix/templates/monorepo;
        };
      };
    }
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in {
      formatter = pkgs.alejandra;

      packages = let
        # Based on the definition of symlinkJoin but specific to merging datapacks.
        # This makes releasing and testing a bit simpler
        joinDataPacks = name: packages:
          pkgs.runCommand name {
            inherit packages;
            passAsFile = ["packages"];
          } ''
            mkdir -p $out/datapacks $out/source
            for path in $(cat $packagesPath); do
              cp $path/datapacks/* $out/datapacks
              cp -R $path/source/* $out/source
            done
          '';
      in rec {
        afk = pkgs.callPackage ./afk {};
        afk-sleep = pkgs.callPackage ./afk-sleep {};
        afk-message = pkgs.callPackage ./afk-message {};
        afk-dim-names = pkgs.callPackage ./afk-dim-names {};
        pause-day-cycle = pkgs.callPackage ./pause-day-cycle {};
        chickenfix = pkgs.callPackage ./chickenfix {};

        default = all;
        all = joinDataPacks "clo4-datapacks" [
          afk
          afk-sleep
          afk-message
          afk-dim-names
          pause-day-cycle
          chickenfix
        ];
      };
    }));
}
