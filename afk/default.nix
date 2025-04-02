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
  '';

  include = [ "LICENSE" ];
}
