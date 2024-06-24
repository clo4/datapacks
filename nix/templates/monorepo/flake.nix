{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # This is used so your pack formats can be updated independently
    # of the upstream builder. Update with the following command:
    #   $ nix flake lock --update-input mcmeta-summary
    mcmeta-summary = {
      url = "github:misode/mcmeta/summary";
      flake = false;
    };

    datapacks = {
      url = "github:clo4/datapacks";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mcmeta-summary.follows = "mcmeta-summary";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    datapacks,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system}.extend datapacks.overlays.default;
    in {
      packages = rec {
        first-data-pack = pkgs.callPackage ./first-data-pack {};
        second-data-pack = pkgs.callPackage ./second-data-pack {};

        all = pkgs.joinDataPacks "all-data-packs" [
          first-data-pack
          second-data-pack
        ];
        default = all;
      };
    });
}
