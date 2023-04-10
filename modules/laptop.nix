{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  services.tlp.enable = true;

  home-manager.users.${user} = {
    home.packages = [ pkgs.brightnessctl ];

    programs.i3status = {
      modules = {
        "battery all" = {
          position = 4;
          settings = {
            format = "%status  %percentage";
            format_down = "No battery";
            integer_battery_capacity = true;
            status_chr = "CHR";
            status_bat = "BAT";
            status_unk = "BAT";
            status_full = "BAT";
            path = "/sys/class/power_supply/BAT%d/uevent";
            low_threshold = 10;
            threshold_type = "percentage";
            last_full_capacity = true;
          };
        };
      };
    };
  };
}
