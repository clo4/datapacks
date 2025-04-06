{ buildDataPack }:
buildDataPack {
  name = "afk-sit";
  version = "1.0.1";

  src = ./.;

  include = [ "LICENSE" ];
}
