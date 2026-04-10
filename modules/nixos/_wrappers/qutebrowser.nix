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

  fileselectSettings = lib.filterAttrs (_: v: v != null) (
    {
      "fileselect.handler" = config.fileselect.handler;
      "fileselect.single_file.command" = config.fileselect.single_file.command;
      "fileselect.multiple_files.command" = config.fileselect.multiple_files.command;
      "fileselect.folder.command" = config.fileselect.folder.command;
    }
  );

  formatFlatSetting = name: value: "c.${name} = ${pythonize value}";

  configPy = lib.concatStringsSep "\n" (
    [ "config.load_autoconfig(False)" ]
    ++ map formatSetting (flattenSettings config.settings)
    ++ lib.mapAttrsToList formatFlatSetting fileselectSettings
    ++ lib.mapAttrsToList formatSearchEngine config.searchEngines
    ++ lib.mapAttrsToList formatKeyBindings config.keyBindings
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

    fileselect = {
      handler = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Handler for file selection dialogs. Set to `external` to use external commands.";
      };

      single_file.command = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "Command to use for selecting a single file.";
      };

      multiple_files.command = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "Command to use for selecting multiple files.";
      };

      folder.command = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "Command to use for selecting a folder.";
      };
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to config.py.";
    };
  };

  config = {
    package = lib.mkDefault pkgs.qutebrowser;

    # qutebrowser reads from $XDG_CONFIG_HOME/qutebrowser/
    env.XDG_CONFIG_HOME = builtins.dirOf (builtins.dirOf config.constructFiles.configpy.path);

    constructFiles.configpy = {
      relPath = "qutebrowser/config.py";
      content = configPy;
    };

    constructFiles.quickmarks = lib.mkIf (config.quickmarks != { }) {
      relPath = "qutebrowser/quickmarks";
      content = lib.concatStringsSep "\n" (lib.mapAttrsToList formatQuickmark config.quickmarks) + "\n";
    };

    constructFiles.bookmarks = {
      relPath = "qutebrowser/bookmarks/urls";
      content = "";
    };

    constructFiles.greasemonkey = {
      relPath = "qutebrowser/greasemonkey/.keep";
      content = "";
    };

    meta.maintainers = [ ];
  };
}
