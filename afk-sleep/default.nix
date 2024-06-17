{buildDataPack}:
buildDataPack {
  pname = "afk-sleep";
  version = "1.2.1";
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
    patch -p0 -f -i clumsy_no_macro_compat.patch
  '';

  zip = [
    "LICENSE"
    "pack.png"
    "pack.mcmeta"
    "data"
  ];
}
