{ buildDataPack }:
buildDataPack {
  name = "expensive-boats";
  version = "1.0.0";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
