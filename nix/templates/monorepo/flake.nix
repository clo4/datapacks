{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    #
    # 📍 Add this repo as an input
    #
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
      #
      # 📍 Extend nixpkgs with the overlay
      #
      pkgs = nixpkgs.legacyPackages.${system}.extend datapacks.overlays.default;
    in {
      packages = rec {
        #
        # 📍 Create the data pack packages
        #    With the overlay applied, both have access to mkDataPack
        #
        first-data-pack = pkgs.callPackage ./first-data-pack {};
        second-data-pack = pkgs.callPackage ./second-data-pack {};

        #
        # 📍 Create a package that builds them all
        #
        all = pkgs.symlinkJoin {
          name = "all-data-packs";
          paths = [first-data-pack second-data-pack];
        };
        default = all;
      };
    });
}
