argparse --name=build-test h/help z/zip V/say -- $argv

if set -q _flag_help
    echo "Usage: build-and-copy [OPTIONS] [DATAPACK]..."
    echo
    echo "Builds and copies data packs to a world, for faster iteration."
    echo "Requires \$DATAPACK_DIR to be set."
    echo
    echo "Options:"
    echo "  -h, --help    Print this message"
    echo "  -z, --zip     Copy the zipped files instead of source directories"
    echo "  -V, --say     Announce when the datapacks have been copied using 'say'"
    exit
end

set datapack_result_directory source
if set -q _flag_zip
    set datapack_result_directory datapacks
end

if set -q _flag_say; and command -q say
    function maybe_say
        say $argv
    end
else
    function maybe_say
    end
end

if not set -q DATAPACK_DIR
    or test ! -d $DATAPACK_DIR
    echo "DATAPACK_DIR must be set to a directory."
    maybe_say Failed
    exit 1
end

set git_root (git rev-parse --git-dir | path dirname)

set datapacks_to_build
for arg in $argv
    set pack_name (path basename -- $arg)
    if test ! -d $git_root/$pack_name
        echo "Invalid pack name: '$pack_name'"
        maybe_say Failed
        exit 1
    end
    set --append datapacks_to_build $pack_name
end

if test (count $datapacks_to_build) -eq 0
    set datapacks_to_build default
end

for result in result*
    rm $result
end

if test (count $datapacks_to_build) -eq 1
    set build_pkgs .#$datapacks_to_build
else
    set build_pkgs .#{(string join , -- $datapacks_to_build)}
end

nix build $build_pkgs
or begin
    maybe_say Failed
    exit 1
end

for datapack in $DATAPACK_DIR/*
    rm -rf $datapack
end

for datapack in result*/$datapack_result_directory/*
    echo "Copying $(path basename -- $datapack)"
    cp -R "$datapack" "$DATAPACK_DIR"
end

# Copied directly from the Nix store, each datapack will be r--r--r--
# until the permissions are changed manually.
for datapack in $DATAPACK_DIR/*
    chmod -R +w $datapack
end

set world_name (path basename (path dirname $DATAPACK_DIR))
echo "Successfully copied data packs to world datapacks directory of '$world_name'"
maybe_say Done
