{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  services.tlp.enable = true;

  home-manager.users.${user.name} = {
    home.packages = [ pkgs.brightnessctl ];
  };
}
