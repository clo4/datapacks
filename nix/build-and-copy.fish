argparse --name=build-test h/help z/zip -- $argv

if set -q _flag_help
    echo "Usage: build-and-copy [OPTIONS] [DATAPACK]..."
    echo
    echo "Builds and copies data packs to a world, for faster iteration."
    echo "Requires \$DATAPACK_DIR to be set."
    echo
    echo "Options:"
    echo "  -h, --help    Print this message"
    echo "  -z, --zip     Copy the zipped files instead of source directories"
    exit
end

set datapack_result_directory source
if set -q _flag_zip
    set datapack_result_directory datapacks
end

if not set -q DATAPACK_DIR
    or test ! -d $DATAPACK_DIR
    echo "DATAPACK_DIR must be set to a directory."
    exit 1
end

if test (count $argv) -eq 0
    set $argv default
end

for result in result*
    rm $result
end

if test (count $argv) -eq 1
    set build_pkgs .#$argv
else
    set build_pkgs .#{(string join , -- $argv)}
end

nix build $build_pkgs
or exit 1

for datapack in $DATAPACK_DIR/*
    rm -rf $datapack
end

for datapack in result*/$datapack_result_directory/*
    cp -R "$datapack" "$DATAPACK_DIR"
end

# Copied directly from the Nix store, each datapack will be r--r--r--
# until the permissions are changed manually.
for datapack in $DATAPACK_DIR/*
    chmod -R +w $datapack
end

set world_name (path basename (path dirname $DATAPACK_DIR))
echo "Successfully copied data packs to world datapacks directory of '$world_name'"
