{ config, args, lib, ... }:
let
  inherit (args) user;
in
lib.mkIf config.laptop {
  home-manager.users.${user} = {
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
