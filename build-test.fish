#!/usr/bin/env fish

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

rm $DATAPACK_DIR/*

for datapack in result*/datapacks/*
    cp "$datapack" "$DATAPACK_DIR"
end
chmod +w $DATAPACK_DIR/*.zip
