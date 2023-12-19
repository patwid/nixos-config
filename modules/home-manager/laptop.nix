{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) laptop;
in
lib.mkIf (laptop) {
  home.packages = [ pkgs.brightnessctl ];
}
