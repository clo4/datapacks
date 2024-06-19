{
  stdenvNoCC,
  zip,
}: {
  mkDataPack = {
    name,
    version,
    src,
    packNameFormat ? null,
    include ? [],
    prepare ? "",
  }: let
    pack = (builtins.fromJSON (builtins.readFile "${src}/pack.mcmeta")).pack;

    packFormats = import ./pack-formats.nix;

    getPackFormat = minOrMax: let
      supportedFormatIndex =
        if minOrMax == "min"
        then 0
        else 1;
      supportedFormatAttr =
        if minOrMax == "min"
        then "min_inclusive"
        else "max_inclusive";
    in
      if builtins.hasAttr "supported_formats" pack
      then
        if builtins.isList pack.supported_formats
        then builtins.elemAt pack.supported_formats supportedFormatIndex
        else pack.supported_formats.${supportedFormatAttr}
      else pack.pack_format;

    getGameVersion = minOrMax: let
      packFormat = getPackFormat minOrMax;
    in
      packFormats."${builtins.toString packFormat}".${minOrMax};

    nameFormat =
      if ! builtins.isNull packNameFormat
      then packNameFormat
      else
        {
          name,
          version,
          minGameVersion,
          maxGameVersion,
        }: let
          gameVersionRange =
            if minGameVersion == maxGameVersion
            then "${minGameVersion}"
            else "${minGameVersion}-${maxGameVersion}";
        in "${name}+v${version}+mc${gameVersionRange}.zip";
  in
    stdenvNoCC.mkDerivation rec {
      pname = name;
      inherit version src prepare;

      passAsFile = ["prepare"];
      nativeBuildInputs = [
        zip
      ];

      include = ["data" "pack.mcmeta" "pack.png"];

      buildPhase = ''
        if [ -s "$preparePath" ]; then
          source "$preparePath"
        fi
        zip -r datapack.zip $include
      '';

      installPhase = let
        minGameVersion = getGameVersion "min";
        maxGameVersion = getGameVersion "max";
        zipName = nameFormat {inherit name version minGameVersion maxGameVersion;};
      in ''
        mkdir -p $out/datapacks
        mv datapack.zip $out/datapacks/${zipName}
      '';
    };
}
