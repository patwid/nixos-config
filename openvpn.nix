{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  programs.openvpn3.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
