{
  stdenvNoCC,
  zip,
  unzip,
}: {
  buildDataPack = {
    #
    # name:
    #   The name of the data pack.
    #
    name,
    #
    # version:
    #   The version of the data pack.
    #
    version,
    #
    # src:
    #   The source files that will be used to build.
    #
    src,
    #
    # packNameFormat:
    #   An optional function used for generating the data pack zip file name.
    #
    packNameFormat ? null,
    #
    # include:
    #   An optional list of file names to be included in the output zip.
    #
    include ? [],
    #
    # preprocess:
    #   Optional Bash script to be executed before zipping the files.
    #
    preprocess ? "",
    #
    # nativeBuildInputs:
    #   Additonal dependencies that are required in order to build or preprocess.
    #
    nativeBuildInputs ? [],
  } @ attrs: let
    # packFormats is an attrset in the form of { "<pack format>" = { min = <string>; max = <string>; }; }
    # min/max attrs will be the full release if it exists, or a
    # snapshot / prerelease / release candidate if not.
    packFormats =
      builtins.mapAttrs (format: {
        releases,
        versions,
      }: {
        # `versions` is guaranteed to have a min and max as a pack format *must*
        # have been introduced in at least one version but may not have been included
        # in a stable release.
        # `releases` will always be preferred (if available) for readability.
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
            if ! builtins.isNull (builtins.match "[[:digit:]]\\.[[:digit:]][[:digit:]]?" maxGameVersion)
            then "${maxGameVersion}.0"
            else maxGameVersion;

          gameVersionRange =
            if minGameVersion == maxGameVersion
            then "${minGameVersion}"
            else "${minGameVersion}-${maxGameVersionWithZero}";
        in "${name}+v${version}+mc${gameVersionRange}";
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
            # Should this also check if there's a valid pack.mcmeta file?

            runHook postCheck
          '';

        installPhase =
          attrs.installPhase
          or (let
            minGameVersion = getGameVersion "min";
            maxGameVersion = getGameVersion "max";
            outputName = nameFormat {inherit name version minGameVersion maxGameVersion;};
          in ''
            runHook preInstall

            # using `datapacks` for zips, `dist` for unzipped sources
            mkdir -p $out/datapacks $out/source/${outputName}

            mv datapack.zip $out/datapacks/${outputName}.zip
            mv $zipFiles $out/source/${outputName}

            runHook postInstall
          '');

        # This phase is unnecessary because there is no executable binary
        # being produced, only a static asset.
        fixupPhase =
          attrs.fixupPhase
          or ''
            runHook preFixup
            runHook postFixup
          '';

        # This phase is unnecessary because the source is produced as part
        # of the normal build phase.
        distPhase =
          attrs.distPhase
          or ''
            runHook preDist
            runHook postDist
          '';

        # This phase is unnecessary because once the data pack has been moved
        # to the `datapacks` folder there is nothing left to check.
        installCheckPhase =
          attrs.installCheckPhase
          or ''
            runHook preInstallCheck
            runHook postInstallCheck
          '';
      });
}
