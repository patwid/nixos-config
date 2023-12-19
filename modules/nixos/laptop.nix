{ config, lib, pkgs, ... }:
let
  inherit (config) user laptop;
in
{
  options.laptop = lib.mkEnableOption { };

  config = lib.mkIf (laptop) {
    services.tlp.enable = true;
    services.upower.enable = true;

    # Events can be monitored the following command:
    #   $ udevadm monitor --property --subsystem-match=power_supply
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", \
      ATTR{status}=="Discharging", \
      ATTR{capacity}=="5", \
      ENV{DBUS_SESSION_BUS_ADDRESS}="unix:path=/run/user/1000/bus", \
      RUN+="${pkgs.su}/bin/su ${user.name} -c ${pkgs.notify-low-battery}/bin/notify-low-battery"
    '';

    powerManagement.powertop.enable = true;
  };
}
