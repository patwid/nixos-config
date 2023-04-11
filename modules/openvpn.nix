{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
in
lib.mkIf config.remoteWork {
  programs.openvpn3.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
