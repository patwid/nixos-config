{ args, config, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) colors;
in
{
  home-manager.users.${user} = {
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
  };
}
