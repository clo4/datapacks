# Nix Datapack Builder

I needed a simpler way to build multiple datapacks and extend the build logic.
Naturally the first thing I tried was a Bash script, which is a legendarily good
decision that always works out and never introduces more headaches.

Anyway, I ended up with a build system based on Nix. Here's a quick example for
a datapack if you want to use it too:

Create a `flake.nix` and add an input with this repository. You'll use the
overlay. It's a nix flake, so there's a little bit of boilerplate before you can jump in,
but once you have the structure set up it's so easy to start hacking on your datapack with
a reliable build system that also gives you the flexibility to change it over time.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/unstable";
    flake-utils.url = "github:numtide/flake-utils";

    #
    # 📍 1. Add this repository as an input
    #
    datapacks = {
      url = "github:clo4/datapacks";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, datapacks }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      #
      # 📍 2. Extend nixpkgs with its overlay
      #
      pkgs = nixpkgs.legacyPackages.${system}.extend datapacks.overlays.default;
    in {
      #
      # 📍 3. Use the `mkDataPack` function to define the data pack
      #
      packages.my-data-pack = pkgs.mkDataPack {
        name = "my-data-pack";
        version = "0.1";

        src = ./.;

        # 📍 4. OPTIONAL: Prepare the directory for zipping
        prepare = ''
          shopt -s nullglob globstar
          for dir in **/function; do
            cp -R $dir ''${dir}s
          done
        '';

        # 📍 5. OPTIONAL: Add some other files to the zip
        include = ["LICENSE"];
      };
    });
}
```

You can use this same structure to define multiple output packages.

Unlike `stdenv.mkDerivation`, I'm actually documenting the arguments this takes ;)

- `name` is a **string** which is the name of the data pack
- `version` is a **string**, the version of the data pack
- `src` is a **path** to a directory containing the `pack.mcmeta` - this is the source that will be built.
- `include` is an **optional list of strings** which is the additional files that will be included. By default, 
- `prepare` is an **optional string**, a Bash script that will execute before the contents are zipped.
- `packNameFormat` is a **function** that generates the name of the output zip file. It takes an attrset with the following properties, and returns a string:
  - `name` - the name of the data pack
  - `version` - the version of the data pack
  - `minGameVersion` - the minimum Minecraft version that the data pack supports (inferred from `pack.mcmeta`)
  - `maxGameVersion` - the maximum Minecraft version that the data pack supports (inferred from `pack.mcmeta`)
