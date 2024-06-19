{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
  }:
    {
      overlays.default = final: prev: {
        inherit (final.callPackage (import ./nix/builder.nix) {}) mkDataPack;
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
            mkdir -p $out/datapacks
            for path in $(cat $packagesPath); do
              cp $path/datapacks/* $out/datapacks
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
