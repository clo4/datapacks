{ buildDataPack }:
buildDataPack {
  name = "no-free-deaths";
  version = "1.1.0";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
