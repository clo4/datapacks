{ buildDataPack }:
buildDataPack {
  name = "afk-immunity";
  version = "1.0.0";

  src = ./.;

  include = [ "LICENSE" ];
}
