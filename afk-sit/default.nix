{ buildDataPack }:
buildDataPack {
  name = "afk-sit";
  version = "1.0.1";

  src = ./.;

  preprocess = ''
    shopt -s nullglob globstar
    pushd data
    for dir in */function */advancement */predicate */tags/*; do
      cp -r $dir ''${dir}s
    done
    popd
    touch **
  '';

  include = [ "LICENSE" ];
}
