{
  config,
  lib,
  pkgs,
  wrappers,
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
