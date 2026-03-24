{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  toSCFG =
    indent: attrs:
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: value:
        if builtins.isList value then
          "${indent}${name} ${lib.concatStringsSep " " (map (v: toString v) value)}"
        else if builtins.isAttrs value then
          let
            params =
              if value ? "_params" then " ${lib.concatStringsSep " " (map toString value._params)}" else "";
            children = lib.filterAttrs (n: _: n != "_params") value;
          in
          if children == { } then
            "${indent}${name}${params}"
          else
            "${indent}${name}${params} {\n${toSCFG "${indent}\t" children}\n${indent}}"
        else
          "${indent}${name} ${toString value}"
      ) attrs
    );
in
{
  imports = [ wlib.modules.default ];

  options = {
    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = ''
        Configuration for senpai. For a complete list of options, see
        {manpage}`senpai(5)`.
      '';
    };
  };

  config = {
    flags."-config" = config.constructFiles.config.path;

    package = lib.mkDefault pkgs.senpai;

    constructFiles.config = {
      relPath = "senpai.scfg";
      content = toSCFG "" config.settings;
    };

    meta.maintainers = [ ];
  };
}
