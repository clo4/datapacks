{ buildDataPack }:
buildDataPack {
  name = "first-data-pack";
  version = "0.1.0";
  src = ./.;

  # Remove this if you don't need any custom build steps.
  preprocess = ''
    echo "Some very complicated build step"
  '';

  # Remove this if you don't need to include any more files.
  include = [ "LICENSE" ];
}
