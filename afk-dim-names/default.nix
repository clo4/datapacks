{mkDataPack}:
mkDataPack {
  name = "afk-dim-names";
  version = "1.0.1";

  src = ./.;

  prepare = ''
    shopt -s nullglob globstar
    pushd data
    for dir in **/function **/advancement; do
      cp -r $dir ''${dir}s
    done
    popd
    touch **
  '';

  include = ["LICENSE"];
}
