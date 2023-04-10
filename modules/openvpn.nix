{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  programs.openvpn3.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
