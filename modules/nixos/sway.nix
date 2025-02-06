{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user;
in
{
  options = {
    output = lib.mkOption {
      type = with lib; types.attrsOf (types.attrsOf types.str);
      default = { };
    };

    workspaceOutputAssign = lib.mkOption {
      type =
        with lib;
        types.listOf (
          types.submodule {
            options = {
              workspace = lib.mkOption {
                type = types.str;
                default = "";
              };

              output = lib.mkOption {
                type = types.either types.str (types.listOf types.str);
                default = "";
                # apply = types.lists.toList;
              };
            };
          }
        );
      default = [ ];
    };

    swayExtraConfig = lib.mkOption {
      type = with lib; types.str;
      default = "";
    };
  };

  config = {
    users.users.${user.name}.extraGroups = [
      "input"
      "video"
      "audio"
    ];

    programs = {
      sway = {
        enable = true;
      };
    };
  };
}
