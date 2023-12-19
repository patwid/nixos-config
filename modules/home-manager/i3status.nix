{ nixosConfig, lib, pkgs, ... }:
let
  inherit (nixosConfig) colors laptop;
in
lib.mkMerge [
  {
    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        color_good = "${colors.green}";
        color_degraded = "${colors.yellow}";
        color_bad = "${colors.red}";
        interval = 5;
      };
      modules = {
        "load" = {
          position = 1;
          settings = {
            format = "";
            format_above_threshold = "CPU  %1min";
            max_threshold = 16;
          };
        };
        "memory" = {
          position = 2;
          settings = {
            format = "";
            threshold_degraded = "5G";
            format_degraded = "MEM  < %available";
          };
        };
        "path_exists VPN" = {
          position = 3;
          settings = {
            format = "VPN";
            format_down = "";
            path = "/proc/sys/net/ipv4/conf/tun0";
          };
        };
        "tztime date" = {
          position = 5;
          settings.format = "%a, %d %b";
        };
        "tztime time" = {
          position = 6;
          settings.format = "%H:%M";
        };
      };
    };
  }

  (lib.mkIf (laptop) {
    programs.i3status.modules = {
      "battery 0" = {
        position = 4;
        settings = {
          format = "%status  %percentage";
          format_down = "No battery";
          integer_battery_capacity = true;
          status_chr = "CHR";
          status_bat = "BAT";
          status_unk = "BAT";
          status_full = "BAT";
          path = "/sys/class/power_supply/macsmc-battery/uevent";
          low_threshold = 10;
          threshold_type = "percentage";
          last_full_capacity = true;
        };
      };
    };
  })
]
