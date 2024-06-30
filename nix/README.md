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

## Example

```nix
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
```

## `buildDataPack`

This is a specialised wrapper around `mkDerivation` that will produce a datapack
Zip file.

The following files are automatically included in the Zip:

- `data/`
- `pack.mcmeta`
- `pack.png`

Because `pack.mcmeta` is a required file for datapacks, building will fail if
this is not present. It is also used to infer the supported game version(s),
which are used while building the pack (naming the output file).

You can include additional files with the `include` attribute. See
[Attributes](#attributes) below for all the possible customisations.

### Attributes

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

## `joinDataPacks`

The overlay also provides the `joinDataPacks` function, which is used to build
multiple data packs and produce a single output containing all of them and all
their sources. There is an example usage of this
[in the `monorepo` template](./templates/monorepo/flake.nix).

## Pack formats

This flake has a mapping from pack format to game version, provided by its
mcmeta-summary input. This input should be auto updated, but in case you want to
override it or control its version manually, you can override it as follows:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    #
    # 1. Create the input to your own flake
    #
    mcmeta-summary = {
      url = "github:misode/mcmeta/summary";
      flake = false;
    };

    datapacks = {
      url = "github:clo4/datapacks";
      inputs.nixpkgs.follows = "nixpkgs";
      #
      # 2. Set the `clo4/datapacks` mcmeta-summary input to follow yours
      #
      inputs.mcmeta-summary.follows = "mcmeta-summary";
    };
  };
}
```

Unfortunately, Mojang doesn't provide a history of this data anywhere, so it
must be gathered from third party sources. `misode/mcmeta` checks for updates
every 15 minutes, so it should be as close to real-time as is feasible.

If the build is failing because of your pack format, first try to update your
`datapacks` input (`nix flake update`). If that doesn't resolve it, try
overriding the mcmeta-summary input as shown above.
