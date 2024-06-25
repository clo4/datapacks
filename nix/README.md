# Nix Datapack Builder

I needed a simpler way to build multiple datapacks and extend the build logic.
Naturally the first thing I tried was a Bash script, which is a legendarily good
decision that always works out and never introduces more headaches.

Anyway, I ended up with a build system based on Nix. Here's a quick example for
a datapack if you want to use it too:

Create a `flake.nix` and add an input for this repository. You'll use the
overlay. It's a nix flake, so there's a little bit of boilerplate before you can
jump in, but once you have the structure set up it's so easy to start hacking on
your datapack with a reliable build system that also gives you the flexibility
to change it over time.

```nix
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
```

You can use this same structure to define multiple output packages.

- `name` is a **string** which is the name of the data pack
- `version` is a **string**, the version of the data pack
- `src` is a **path** to a directory containing the `pack.mcmeta` - this is the
  source that will be built.
- `include` is an **optional list of strings** which is the additional files
  that will be included. By default,
- `preprocess` is an **optional string**, a Bash script that will execute before
  the contents are zipped.
- `packNameFormat` is a **function** that generates the name of the output zip
  file. It takes an attrset with the following properties, and returns a string:
  - `name` - the name of the data pack
  - `version` - the version of the data pack
  - `minGameVersion` - the minimum Minecraft version that the data pack supports
    (inferred from `pack.mcmeta`)
  - `maxGameVersion` - the maximum Minecraft version that the data pack supports
    (inferred from `pack.mcmeta`)

You can still use any of the other attributes that `stdenv.mkDerivation` uses,
although this is all that is necessary to use to build a data pack.

In any of the phases, including your `preprocess` step, you have access to the
`packName` environment variable. This is the name, not including the extension,
of the output pack.

The overlay also provides the `joinDataPacks` function, which is used to build
multiple data packs and produce a single output containing all of them and all
their sources. There is an example usage of this
[in the `monorepo` template](./templates/monorepo/flake.nix).
