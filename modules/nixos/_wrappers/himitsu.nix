{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  toINI = lib.generators.toINI { };
in
{
  imports = [ wlib.modules.default ];

  options = {
    settings = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
      default = { };
      description = ''
        Configuration for himitsu.ini. Keys are INI section names,
        values are attrsets of settings within that section.
        See {manpage}`himitsu.ini(5)`.
      '';
    };
  };

  config = {
    package = lib.mkDefault pkgs.himitsu;
    binName = "himitsud";
    exePath = "bin/himitsud";

    flags."-C" = config.constructFiles.config.path;

    constructFiles.config = {
      relPath = "himitsu.ini";
      content = toINI config.settings;
    };

    meta.maintainers = [ ];
  };
}
