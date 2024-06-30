{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    datapacks = {
      url = "github:clo4/datapacks";
      inputs.nixpkgs.follows = "nixpkgs";
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
