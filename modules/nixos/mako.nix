{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) colors;
in
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) libnotify mako;
  };
}
