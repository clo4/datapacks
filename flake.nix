{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mcmeta-summary = {
      url = "github:misode/mcmeta/summary";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      mcmeta-summary,
    }:
    {
      overlays.default =
        final: prev:
        let
          builder = final.callPackage (import ./nix/builder.nix) {
            minecraftVersionsSummary = builtins.fromJSON (
              builtins.readFile "${mcmeta-summary}/versions/data.json"
            );
          };
        in
        {
          inherit (builder) buildDataPack joinDataPacks;
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
    // (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
      in
      rec {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nixd
            pkgs.deno
            pkgs.zip
            pkgs.unzip
            pkgs.fish
            self.packages.${system}.build-and-copy
            formatter
          ];
        };

        apps = rec {
          default = build-and-copy;
          build-and-copy = {
            type = "app";
            program = "${self.packages.${system}.build-and-copy}/bin/build-and-copy";
          };
        };

        packages = rec {
          afk = pkgs.callPackage ./afk { };
          afk-sleep = pkgs.callPackage ./afk-sleep { };
          afk-message = pkgs.callPackage ./afk-message { };
          afk-dim-names = pkgs.callPackage ./afk-dim-names { };
          pause-day-cycle = pkgs.callPackage ./pause-day-cycle { };
          chickenfix = pkgs.callPackage ./chickenfix { };
          drop-xp = pkgs.callPackage ./drop-xp { };
          respawn-sickness = pkgs.callPackage ./respawn-sickness { };

          all = pkgs.joinDataPacks "clo4-datapacks" [
            afk
            afk-sleep
            afk-message
            afk-dim-names
            pause-day-cycle
            chickenfix
            drop-xp
            respawn-sickness
          ];
          default = all;

          build-and-copy = pkgs.writeScriptBin "build-and-copy" ''
            #!${pkgs.fish}/bin/fish
            ${builtins.readFile ./nix/build-and-copy.fish}
          '';
        };
      }
    ));
}
