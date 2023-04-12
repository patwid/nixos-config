{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
  customGroup = args ? group && args ? gid;
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      description = "${user}";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [ ];
    }
    // lib.attrsets.optionalAttrs customGroup {
      inherit (args) group;
    };
  }
  // lib.attrsets.optionalAttrs customGroup {
    groups.${args.group} = {
      inherit (args) gid;
    };
  };
}
