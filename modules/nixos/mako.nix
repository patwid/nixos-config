{ config, lib, pkgs, wrappers, ... }:
let
  inherit (config) colors;
in
{
  environment.systemPackages = [
    pkgs.libnotify
    pkgs.mako
  ];
}
