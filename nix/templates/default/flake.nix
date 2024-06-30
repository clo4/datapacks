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
        my-data-pack = pkgs.buildDataPack {
          name = "my-data-pack";
          version = "1.0.0";
          src = ./.;

          # Remove this if you don't need any custom build steps.
          preprocess = ''
            echo "Some very complicated build step"
          '';

          # Remove this if you don't need to include any more files.
          include = ["LICENSE"];
        };

        default = my-data-pack;
      };
    });
}
