{ config, args, lib, pkgs, ... }:
let
  inherit (config) work;
  inherit (args) user;
in
lib.mkIf (work.remote) {
  programs.openvpn3.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.networkmanager-openvpn ];
  };
}
