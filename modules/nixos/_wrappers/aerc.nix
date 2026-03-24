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
        Configuration for aerc.conf. Keys are INI section names,
        values are attrsets of settings within that section.
        See {manpage}`aerc-config(5)`.
      '';
    };

    accounts = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
      default = { };
      description = ''
        Account configuration for accounts.conf. Keys are account names,
        values are attrsets of account settings.
        See {manpage}`aerc-accounts(5)`.
      '';
    };
  };

  config = {
    package = lib.mkDefault pkgs.aerc;

    # aerc reads from $XDG_CONFIG_HOME/aerc/{aerc.conf,accounts.conf}
    env.XDG_CONFIG_HOME = builtins.dirOf (builtins.dirOf config.constructFiles.config.path);

    constructFiles.config = {
      relPath = "aerc/aerc.conf";
      content = toINI config.settings;
    };

    constructFiles.accounts = {
      relPath = "aerc/accounts.conf";
      content = toINI config.accounts;
    };

    meta.maintainers = [ ];
  };
}
