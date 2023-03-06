{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  programs.openvpn3.enable = true;

  home-manager.users.${user.name} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
