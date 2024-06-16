{buildDataPack}:
buildDataPack {
  pname = "afk-message";
  version = "1.1.1";
  minMinecraftVersion = "1.16.x";
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