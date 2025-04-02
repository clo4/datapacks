{ buildDataPack }:
buildDataPack {
  name = "afk-sit";
  version = "1.0.0";

  src = ./.;

  include = [ "LICENSE" ];
}
