{ buildDataPack }:
buildDataPack {
  name = "afk";
  version = "1.1.2";

  src = ./.;

  include = [ "LICENSE" ];
}
