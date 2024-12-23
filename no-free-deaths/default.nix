{ buildDataPack }:
buildDataPack {
  name = "no-free-deaths";
  version = "1.1.1";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
