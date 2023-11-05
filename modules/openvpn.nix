{ config, lib, pkgs, ... }:
let
  inherit (config) user work;
in
lib.mkIf (work.remote) {
  programs.openvpn3.enable = true;

  home-manager.users.${user.name} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
