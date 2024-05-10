{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) laptop;
in
lib.mkIf (laptop) {
  home.packages = [ pkgs.brightnessctl ];
}
