{ config, lib, pkgs, ... }:
let
  inherit (config) work;
in
lib.mkIf (work.remote) {
  programs.openvpn3.enable = true;
}
