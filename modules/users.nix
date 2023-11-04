{ config, lib, pkgs, ... }:
let
  inherit (config) user uid group gid;
in
{
  options.user = lib.mkOption {
    type = lib.types.str;
    default = "patwid";
  };

  options.uid = lib.mkOption {
    type = lib.types.nullOr lib.types.int;
    default = null;
  };

  options.group = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
  };

  options.gid = lib.mkOption {
    type = lib.types.nullOr lib.types.int;
    default = null;
  };

  config = lib.mkMerge [
    {
      users.users.${user} = {
        isNormalUser = true;
        description = user;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [ ];
      };
    }

    (lib.mkIf (uid != null) {
      users.users.${user} = {
        inherit uid;
      };
    })

    (lib.mkIf (group != null && gid != null) {
      users.users.${user} = {
        inherit (config) group;
      };

      users.groups.${group} = {
        inherit (config) gid;
      };
    })
  ];
}
