{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) laptop;
in
{
  options.laptop = lib.mkEnableOption { };

  config = lib.mkMerge [
    (lib.mkIf laptop {
      services.tlp.enable = true;
      services.upower.enable = true;
      powerManagement.powertop.enable = true;

      environment.systemPackages = [ pkgs.brightnessctl ];
    })

    (lib.mkIf (!laptop) {
      powerManagement.cpuFreqGovernor = "performance";
    })
  ];
}
