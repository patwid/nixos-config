{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user group;
in
{
  options = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "patwid";
      };

      uid = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
      };
    };

    group = {
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };

      gid = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
      };
    };
  };

  config = lib.mkMerge [
    {
      users.users.${user.name} = {
        isNormalUser = true;
        description = user.name;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [ ];
      };
    }

    (lib.mkIf (user.uid != null) {
      users.users.${user.name} = {
        inherit (user) uid;
      };
    })

    (lib.mkIf (group.name != null && group.gid != null) {
      users.users.${user.name} = {
        group = group.name;
      };

      users.groups.${group.name} = {
        inherit (group) gid;
      };
    })
  ];
}
