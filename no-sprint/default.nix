{ buildDataPack }:
buildDataPack {
  name = "no-sprint";
  version = "1.0.0";

  src = ./.;

  include = [
    "LICENSE"
  ];
}
