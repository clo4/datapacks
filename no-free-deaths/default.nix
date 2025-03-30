{ buildDataPack }:
buildDataPack {
  name = "no-free-deaths";
  version = "1.1.2";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
