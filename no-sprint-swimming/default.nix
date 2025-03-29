{ buildDataPack }:
buildDataPack {
  name = "no-sprint-swimming";
  version = "1.0.0";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
