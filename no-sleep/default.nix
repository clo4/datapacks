{ buildDataPack }:
buildDataPack {
  name = "no-sleep";
  version = "1.0.0";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
