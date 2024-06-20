{buildDataPack}:
buildDataPack {
  name = "afk-sleep";
  version = "1.2.1";

  src = ./.;

  preprocess = ''
    shopt -s nullglob globstar
    pushd data
    for dir in **/function **/advancement; do
      cp -r $dir ''${dir}s
    done
    popd
    patch -p0 -f -i clumsy_no_macro_compat.patch
    touch **
  '';

  include = ["LICENSE"];
}
