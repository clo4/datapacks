{ buildDataPack }:
buildDataPack {
  name = "afk-sleep";
  version = "1.3.1";

  src = ./.;

  preprocess = ''
    shopt -s nullglob globstar
    pushd data
    for dir in **/function **/advancement **/predicate; do
      cp -r $dir ''${dir}s
    done
    popd
    touch **
  '';

  include = [ "LICENSE" ];
}
