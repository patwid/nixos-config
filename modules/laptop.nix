{ config, args, lib, pkgs, ... }:
let
  inherit (config) laptop;
  inherit (args) user;
in
{
  options.laptop = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf (laptop) {
    services.tlp.enable = true;
    services.upower.enable = true;

    powerManagement.powertop.enable = true;

    home-manager.users.${user} = {
      home.packages = [ pkgs.brightnessctl ];
    };
  };
}
