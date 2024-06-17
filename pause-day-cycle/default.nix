{buildDataPack}:
buildDataPack {
  pname = "pause-day-cycle";
  version = "1.1.1";
  minMinecraftVersion = "1.18.x";
  maxMinecraftVersion = "1.21.0";

  src = ./.;

  preBuild = ''
    shopt -s nullglob globstar
    pushd data
    for dir in **/function **/advancement; do
      cp -r $dir ''${dir}s
    done
    popd
  '';

  zip = [
    "LICENSE"
    "pack.png"
    "pack.mcmeta"
    "data"
  ];
}
