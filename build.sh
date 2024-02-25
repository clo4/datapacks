#!/bin/bash

set -e

# Requires: zip, jq

packs=$(find . -name pack.mcmeta)

if [ -d dist ]; then
  rm -rf dist
fi
mkdir -p dist

wd=$(pwd)

for pack in $packs; do
  cd $wd

  # This can be done using the horrible bash string manipulation, but
  # I dislike that on a spiritual level. I feel it in my whole body.
  dir=$(basename $(dirname $pack))
  name=$(sed 's/-/_/g' <<< $dir)

  # Don't know what could trigger this - maybe if in the future I
  # had a nested datapack for some reason. But for now, not a problem,
  # just being safe.
  if [ ! -d $dir ]; then
    continue
  fi

  echo "Building $dir"

  packversion=$(jq -r .version $dir/version.json)
  mc0=$(jq -r .minecraft[0] $dir/version.json)
  mc1=$(jq -r .minecraft[1] $dir/version.json)

  # zip really wants to include the dir heirarchy, so we have to cd into the directory
  cd $dir

  # Specifying the files to include means I can put assets in the folders in the future
  # and not worry about them being included in the final zips.
  zip -r $wd/dist/$name+v$packversion+mc$mc0-$mc1.zip data pack.mcmeta

  echo
done