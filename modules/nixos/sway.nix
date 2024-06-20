{ config, lib, pkgs, ... }:
let
  inherit (config) user;
in
{
  options.output = lib.mkOption {
    type = with lib; types.attrsOf (types.attrsOf types.str);
    default = { };
  };

  config = {
    users.users.${user.name}.extraGroups = [ "input" "video" "audio" ];

    security.polkit.enable = true;
    hardware.opengl.enable = true;
  };
}
