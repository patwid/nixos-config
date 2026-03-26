{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  pythonize =
    v:
    if v == null then
      "None"
    else if builtins.isBool v then
      (if v then "True" else "False")
    else if builtins.isString v then
      ''"${builtins.replaceStrings [ "\n" ] [ "\\n" ] (lib.escape [ "\\" ''"'' ] v)}"''
    else if builtins.isList v then
      "[${lib.concatStringsSep ", " (map pythonize v)}]"
    else
      toString v;

  flattenSettings =
    x:
    lib.collect (x: !builtins.isAttrs x) (
      lib.mapAttrsRecursive (path: value: [
        (lib.concatStringsSep "." path)
        value
      ]) x
    );

  formatSetting = l: "c.${builtins.elemAt l 0} = ${pythonize (builtins.elemAt l 1)}";

  formatQuickmark = name: url: "${name} ${url}";

  formatSearchEngine = name: url: ''c.url.searchengines["${name}"] = "${url}"'';

  formatKeyBinding =
    mode: key: cmd:
    if cmd == null then
      ''config.unbind("${key}", mode="${mode}")''
    else
      ''config.bind("${key}", "${lib.escape [ ''"'' ] cmd}", mode="${mode}")'';

  formatKeyBindings =
    mode: bindings: lib.concatStringsSep "\n" (lib.mapAttrsToList (formatKeyBinding mode) bindings);

  configPy = lib.concatStringsSep "\n" (
    [ "config.load_autoconfig(False)" ]
    ++ map formatSetting (flattenSettings config.settings)
    ++ lib.mapAttrsToList formatSearchEngine config.searchEngines
    ++ lib.mapAttrsToList formatKeyBindings config.keyBindings
    ++ lib.optional (config.quickmarks != { }) ''

      # Write quickmarks
      import os as _os
      _qm_path = _os.path.join(config.configdir, 'quickmarks')
      with open(_qm_path, 'w') as _f:
          _f.write(${
            pythonize (lib.concatStringsSep "\n" (lib.mapAttrsToList formatQuickmark config.quickmarks) + "\n")
          })
    ''
    ++ lib.optional (config.extraConfig != "") config.extraConfig
  );
in
{
  imports = [ wlib.modules.default ];

  options = {
    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = ''
        Qutebrowser settings. See <https://qutebrowser.org/doc/help/settings.html>.
      '';
    };

    quickmarks = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Quickmarks mapping names to URLs.";
    };

    searchEngines = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Search engines mapping names to URL templates with `{}` placeholder.";
    };

    keyBindings = lib.mkOption {
      type = with lib.types; attrsOf (attrsOf (nullOr str));
      default = { };
      description = "Key bindings mapping modes to key-command pairs.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to config.py.";
    };
  };

  config = {
    flagSeparator = "=";
    flags."--config-py" = config.constructFiles.configpy.path;

    package = lib.mkDefault pkgs.qutebrowser;

    constructFiles.configpy = {
      relPath = "config.py";
      content = configPy;
    };

    meta.maintainers = [ ];
  };
}
