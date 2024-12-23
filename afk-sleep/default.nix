{ buildDataPack }:
buildDataPack {
  name = "afk-sleep";
  version = "1.3.2";

  src = ./.;

  include = [ "LICENSE" ];
}
