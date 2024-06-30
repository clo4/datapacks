{
  stdenvNoCC,
  zip,
  unzip,
  minecraftVersionsSummary,
  lib,
  runCommand,
}: {
  # Based on the definition of symlinkJoin but specific to merging datapacks.
  # This makes releasing and testing a bit simpler
  joinDataPacks = name: packages:
    runCommand name {
      inherit packages;
      passAsFile = ["packages"];
      meta.description = "Create a derivation with the outputs of multiple data packs";
    } ''
      mkdir -p $out/datapacks $out/source
      for path in $(cat $packagesPath); do
        cp $path/datapacks/* $out/datapacks
        cp -R $path/source/* $out/source
      done
    '';

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
    #   Additional dependencies that are required in order to build or preprocess.
    #
    nativeBuildInputs ? [],
  } @ attrs: let
    # Attrset of pack formats containing lists of versions, sorted by data version.
    # The data version is guaranteed to increment with every release, which makes it
    # a stable way to sort the versions.
    # The data contained in each list item can be seen here:
    # https://github.com/misode/mcmeta/blob/summary/versions/data.json
    # Even though the data is already sorted, sorting it again ensures correctness.
    packFormats = let
      groupedPackFormats =
        builtins.groupBy
        ({data_pack_version, ...}: builtins.toString data_pack_version)
        minecraftVersionsSummary;
    in
      builtins.mapAttrs
      (_format: versions: builtins.sort (a: b: a.data_version > b.data_version) versions)
      groupedPackFormats;

    packMeta = builtins.fromJSON (builtins.readFile "${src}/pack.mcmeta");

    packFormat =
      if packMeta.pack ? supported_formats
      then
        if builtins.isList packMeta.pack.supported_formats
        then {
          min = builtins.elemAt packMeta.pack.supported_formats 0;
          max = builtins.elemAt packMeta.pack.supported_formats 1;
        }
        else {
          min = packMeta.pack.supported_formats.min_inclusive;
          max = packMeta.pack.supported_formats.max_inclusive;
        }
      else {
        min = packMeta.pack.pack_format;
        max = packMeta.pack.pack_format;
      };

    # `selector` takes two arguments, the releases and versions lists.
    # `format` is a valid Minecraft data pack format. The versions will have this pack format format.
    selectFormatVersion = selector: format: let
      packFormatStr = builtins.toString format;
      versions = packFormats.${packFormatStr};
      releases = builtins.filter (version: version.type == "release") versions;
    in
      selector releases versions;

    # The releases list may not have any elements, but the versions list is
    # guaranteed to. Taking the first of the list means you'll always get either
    # the first release version or the first snapshot with that format.
    maxGameVersion =
      (selectFormatVersion
        (releases: versions: builtins.head (releases ++ versions))
        packFormat.max)
      .id;

    # The same is true of the min version but in reverse. You have to append instead
    # of prepending, and have to take the last item.
    minGameVersion =
      (selectFormatVersion
        (releases: versions: lib.last (versions ++ releases))
        packFormat.min)
      .id;

    # The default name format is designed to indicate, at a glance, what the
    # name, version, and supported game versions are - in that order.
    # Most of the complexity of this builder is because I want the supported
    # game versions to be generated from the pack formats rather than specified
    # by the end user. This is partly for convenience, but largely for
    # correctness.
    defaultNameFormat = {
      name,
      version,
      minGameVersion,
      maxGameVersion,
    }: let
      # The .0 implies that we're not talking about the whole version range,
      # eg. 1.21 vs 1.21.0
      maxGameVersionWithZero =
        if ! builtins.isNull (builtins.match "[[:digit:]]\\.[[:digit:]][[:digit:]]?" maxGameVersion)
        then "${maxGameVersion}.0"
        else maxGameVersion;

      gameVersionRange =
        if minGameVersion == maxGameVersion
        then "${maxGameVersionWithZero}"
        else "${minGameVersion}-${maxGameVersionWithZero}";
    in "${name}+v${version}+mc${gameVersionRange}";

    formatName =
      if ! builtins.isNull packNameFormat
      then packNameFormat
      else defaultNameFormat;
  in
    stdenvNoCC.mkDerivation ((builtins.removeAttrs attrs ["name"])
      // {
        pname = name;
        inherit version src preprocess;

        meta = {
          description = "Builds a Minecraft data pack from a directory";
          platforms = lib.platforms.all;
        };

        strictDeps = true;
        passAsFile = ["preprocess"] ++ (attrs.passAsFile or []);
        nativeBuildInputs =
          [
            zip
            unzip
          ]
          ++ nativeBuildInputs;

        filesToInclude = ["data" "pack.mcmeta" "pack.png"] ++ include;

        # By default there is likely nothing to patch because there's no system
        # dependent logic happening, but it's not impossible to need the default
        # logic for it. The patch phase is just disabled by default.
        dontPatch = attrs.dontPatch or true;

        # I'm not 100% sure this is the right place to put this logic but it
        # makes sense to me because the idea of the preprocess script is to get
        # the directory into the state where you can build the finished zip file,
        # and that seems like "configuring" to me.
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
            # the default behaviour of `zip` is to just ignore files that don't exist.
            # Because there's no reason that would ever be a mistake, right?
            # Anyway, works for us, not complaining.
            zip -r datapack.zip $filesToInclude

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

        # This is just a variable that can be used in any phase. It's the
        # generated name of the final zip file and source directory.
        packName = formatName {
          inherit
            name
            version
            minGameVersion
            maxGameVersion
            ;
        };
        installPhase =
          attrs.installPhase
          or ''
            runHook preInstall

            # using `datapacks` for zips, `dist` for unzipped sources
            mkdir -p $out/datapacks $out/source/"$packName"

            mv datapack.zip $out/datapacks/"$packName".zip
            cp -R $filesToInclude $out/source/"$packName"

            runHook postInstall
          '';

        # This phase is unnecessary because there is no executable binary
        # being produced, only a static asset.
        dontFixup = attrs.dontFixup or true;
        fixupPhase =
          attrs.fixupPhase
          or ''
            runHook preFixup
            runHook postFixup
          '';

        # This phase is unnecessary because the source is produced as part
        # of the normal build phase.
        doDist = attrs.doDist or false;
        distPhase =
          attrs.distPhase
          or ''
            runHook preDist
            runHook postDist
          '';

        # This phase is unnecessary because once the data pack has been moved
        # to the `datapacks` folder there is nothing left to check.
        doInstallCheck = attrs.doInstallCheck or false;
        installCheckPhase =
          attrs.installCheckPhase
          or ''
            runHook preInstallCheck
            runHook postInstallCheck
          '';
      });
}
