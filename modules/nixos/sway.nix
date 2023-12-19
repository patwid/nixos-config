{ config, lib, pkgs, ... }:
let
  inherit (config) user;
in
{
  options.outputScales = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  config = {
    users.users.${user.name}.extraGroups = [ "input" "video" "audio" ];

    security.polkit.enable = true;
    hardware.opengl.enable = true;
  };
}
