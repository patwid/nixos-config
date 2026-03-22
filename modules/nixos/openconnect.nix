{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) work;
in
lib.mkIf (work.remote) {
  environment.systemPackages = with pkgs; [ openconnect ];

  networking.networkmanager.plugins = with pkgs; [ networkmanager-openconnect ];
}
