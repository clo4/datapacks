# This data has been adapted from the Minecraft wiki:
# https://minecraft.wiki/w/Pack_format#List_of_data_pack_formats
let
  packFormats = builtins.fromJSON (builtins.readFile ./pack-formats.json);
in
  builtins.mapAttrs (format: {
    releases,
    versions,
  }: {
    min = releases.min or versions.min;
    max = releases.max or versions.max;
  })
  packFormats
