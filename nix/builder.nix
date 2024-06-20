{
  stdenvNoCC,
  zip,
  unzip,
}: {
  mkDataPack = {
    name,
    version,
    src,
    packNameFormat ? null,
    include ? [],
    preprocess ? "",
    nativeBuildInputs ? [],
  } @ attrs: let
    # packFormats is an attrset of stringified pack formats to a { min, max } set.
    # min/max attrs will be the full release if it exists, or the
    # snapshot / prerelease / release candidate if not.
    packFormats =
      builtins.mapAttrs (format: {
        releases,
        versions,
      }: {
        min = releases.min or versions.min;
        max = releases.max or versions.max;
      })
      (builtins.fromJSON (builtins.readFile ./pack-formats.json));

    packMeta = builtins.fromJSON (builtins.readFile "${src}/pack.mcmeta");

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
      if packMeta.pack ? supported_formats
      then
        if builtins.isList packMeta.pack.supported_formats
        then builtins.elemAt packMeta.pack.supported_formats supportedFormatIndex
        else packMeta.pack.supported_formats.${supportedFormatAttr}
      else packMeta.pack.pack_format;

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
          maxGameVersionWithZero =
            if ! builtins.isNull (builtins.match "^[[:digit:]]\\.[[:digit:]][[:digit:]]?$" maxGameVersion)
            then "${maxGameVersion}.0"
            else maxGameVersion;

          gameVersionRange =
            if minGameVersion == maxGameVersion
            then "${minGameVersion}"
            else "${minGameVersion}-${maxGameVersionWithZero}";
        in "${name}+v${version}+mc${gameVersionRange}.zip";
  in
    stdenvNoCC.mkDerivation ((builtins.removeAttrs attrs ["name"])
      // {
        pname = name;
        inherit version src preprocess;

        strictDeps = true;
        passAsFile = ["preprocess"] ++ (attrs.passAsFile or []);
        nativeBuildInputs =
          [
            zip
            unzip
          ]
          ++ nativeBuildInputs;

        zipFiles = ["data" "pack.mcmeta" "pack.png"] ++ include;

        configurePhase =
          attrs.configurePhase
          or ''
            runHook preConfigure

            # -s is the same as -f but also checks for a non-zero size
            if [ -s "$preprocessPath" ]; then
              source "$preprocessPath"
            fi

            runHook postConfigure
          '';

        buildPhase =
          attrs.buildPhase
          or ''
            runHook preBuild

            # This is fine to execute if pack.png doesn't exist because for some reason
            # the default behaviour of `zip` is to just ignore filees that don't exist.
            # Because there's no reason that would ever be a mistake, right?
            # Anyway, works for us, not complaining.
            zip -r datapack.zip $zipFiles

            runHook postBuild
          '';

        doCheck = attrs.doCheck or true;
        checkPhase =
          attrs.checkPhase
          or ''
            runHook preCheck

            zip -T datapack.zip

            runHook postCheck
          '';

        installPhase =
          attrs.installPhase
          or (let
            minGameVersion = getGameVersion "min";
            maxGameVersion = getGameVersion "max";
            zipName = nameFormat {inherit name version minGameVersion maxGameVersion;};
          in ''
            runHook preInstall

            # using `datapacks` for zips, `dist` for unzipped sources
            mkdir -p $out/datapacks $out/dist

            mv datapack.zip $out/datapacks/${zipName}
            mv $zipFiles $out/dist

            runHook postInstall
          '');
      });
}
