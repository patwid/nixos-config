{ pkgs, args, ... }:
let
  colors = import ../colors.nix;
in
{
  home-manager.users.${args.user} = {
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
            format_above_threshold = "   %1min";
            max_threshold = 16;
          };
        };
        "memory" = {
          position = 2;
          settings = {
            format = "";
            threshold_degraded = "5G";
            format_degraded = "   < %available";
          };
        };
        "path_exists VPN" = {
          position = 3;
          settings = {
            format = "   VPN";
            format_down = "";
            path = "/proc/sys/net/ipv4/conf/tun0";
          };
        };
        "battery all" = {
          position = 5;
          settings = {
            format = "%status   %percentage";
            format_down = "No battery";
            integer_battery_capacity = true;
            status_chr = "";
            status_bat = "";
            status_unk = "";
            status_full = "";
            path = "/sys/class/power_supply/BAT%d/uevent";
            low_threshold = 10;
            threshold_type = "percentage";
            last_full_capacity = true;
          };
        };
        "tztime date" = {
          position = 6;
          settings.format = "%a, %d %b";
        };
        "tztime time" = {
          position = 7;
          settings.format = "%H:%M";
        };
      };
    };
  };
}
