{ config, args, lib, pkgs, ... }:
let
  inherit (config) user;
  customGroup = args ? group && args ? gid;
in
{
  options.user = lib.mkOption {
    type = lib.types.str;
    default = "patwid";
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

    (lib.mkIf (customGroup) {
      users.users.${user} = {
        inherit (args) group;
      };

      users.groups.${args.group} = {
        inherit (args) gid;
      };
    })
  ];
}
