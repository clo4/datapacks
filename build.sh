#!/bin/bash

packs=$(find . -name pack.mcmeta)

if [ -d dist ]; then
  rm -rf dist
fi
mkdir -p dist

for pack in $packs; do
  dir=$(basename $(dirname $pack))
  # Don't know what could trigger this - maybe if in the future I
  # had a nested datapack for some reason. But for now, not a problem,
  # just being safe.
  if [ ! -d $dir ]; then
    continue
  fi
  echo "Building dist/$dir"
  zip -r dist/$dir.zip $dir/*
done