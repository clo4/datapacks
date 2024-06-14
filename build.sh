#!/usr/bin/env bash

# Requires: zip, jq, (recent-ish) bash

set -e
shopt -s globstar nullglob

packs=$(find . -name pack.mcmeta)

if [ -d dist ]; then
  rm -rf dist/*
fi
mkdir -p dist

if [ -d build ]; then
  rm -rf build/*
fi
mkdir -p build

for pack in $packs; do
  cp -R $(basename $(dirname $pack)) build
done

wd=$(pwd)

for dir in $(ls build); do
  cd $wd/build
  # This can be done using the horrible bash string manipulation, but
  # I dislike that on a spiritual level. I feel it in my whole body.
  # dir=$(basename $(dirname $pack))
  name=$(sed 's/-/_/g' <<< $dir)

  # Don't know what could trigger this - maybe if in the future I
  # had a nested datapack for some reason. But for now, not a problem,
  # just being safe.
  if [ ! -d $dir ]; then
    continue
  fi

  echo "Building $dir"

  # zip really wants to include the dir heirarchy, so we have to cd into the directory
  cd $dir

  packversion=$(jq -r .version version.json)
  mc0=$(jq -r '.minecraft[0]' version.json)
  mc1=$(jq -r '.minecraft[1]' version.json)

  if ! git diff --quiet --exit-code $dir; then
    name+="__DIRTY__DO_NOT_RELEASE"
  fi

  # TODO: Gate on whether pack version 45 is below max and above min
  # This duplicates the function/advancement directories, which makes
  # the structure compatible with older versions
  compat_dirs=$(echo **/function **/advancement)
  for compat_dir in $compat_dirs; do
    cp -R $compat_dir ${compat_dir}s
  done

  # Specifying the files to include means I can put assets in the folders in the future
  # and not worry about them being included in the final zips.
  zip -r $wd/dist/$name+v$packversion+mc$mc0-$mc1.zip LICENSE data pack.mcmeta pack.png

  rm LICENSE

  echo
done
