{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) work;
in
lib.mkIf (work.remote) {
  home.packages = [ pkgs.networkmanager-openvpn ];
}
