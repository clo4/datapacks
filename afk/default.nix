{ buildDataPack }:
buildDataPack {
  name = "afk";
  version = "1.2.1";

  src = ./.;

  preprocess = ''
    shopt -s nullglob globstar
    pushd data
    for dir in **/function **/advancement; do
      cp -r $dir ''${dir}s
    done
    popd
    touch **
    patch -p0 -f < return_run_backport.patch
  '';

  include = [ "LICENSE" ];
}
