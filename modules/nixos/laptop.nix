{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user laptop;
in
{
  options.laptop = lib.mkEnableOption { };

  config = lib.mkIf (laptop) {
    services.tlp.enable = true;
    services.upower.enable = true;
    powerManagement.powertop.enable = true;
  };
}
