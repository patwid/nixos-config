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

  config = lib.mkMerge [
    (lib.mkIf laptop {
      services.tlp.enable = true;
      services.upower.enable = true;
      powerManagement.powertop.enable = true;

      home-manager.users.${user.name} = {
        home.packages = [ pkgs.brightnessctl ];
      };
    })

    (lib.mkIf (!laptop) {
      powerManagement.cpuFreqGovernor = "performance";
    })
  ];
}
