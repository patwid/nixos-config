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
        Configuration for himitsu config.ini used by hissh-agent.
        Keys are INI section names, values are attrsets of settings
        within that section.
      '';
    };
  };

  config = {
    package = lib.mkDefault pkgs.himitsu-ssh;
    binName = "hissh-agent";
    exePath = "bin/hissh-agent";

    # hissh-agent reads from $XDG_CONFIG_HOME/himitsu/config.ini
    env.XDG_CONFIG_HOME = builtins.dirOf (builtins.dirOf config.constructFiles.config.path);

    constructFiles.config = {
      relPath = "himitsu/config.ini";
      content = toINI config.settings;
    };

    meta.maintainers = [ ];
  };
}
