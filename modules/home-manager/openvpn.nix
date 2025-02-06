{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work;
in
lib.mkIf (work.remote) {
  home.packages = [ pkgs.networkmanager-openvpn ];
}
