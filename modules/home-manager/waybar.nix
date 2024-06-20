{ osConfig, config, ... }:
let
  inherit (osConfig) colors laptop;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        mode = "overlay";
        ipc = true;
        margin = "10";

        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-right = [
          "cpu"
          "memory"
          "custom/vpn"
          "battery"
          "clock#date"
          "clock#time"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
        };

        cpu = {
          format = "";
          format-warning = "CPU  {load}";
          states = {
            warning = 75;
          };
        };

        memory = {
          format = "";
          format-warning = "MEM  {avail}G";
          states = {
            warning = 75;
          };
        };

        "custom/vpn" = {
          format = "{}";
          exec = "echo 'VPN'";
          exec-if = "test -d /proc/sys/net/ipv4/conf/tun0";
          interval = 10;
        };

        battery = {
          format = "BAT  {capacity}%";
          design-capacity = true;
          states = {
            warning = 30;
          };
        };

        "clock#date" = {
          format = "{:%a, %d %b}";
        };
      };
    };

    style = ''
      * {
        border-radius: 0;
        border: none;
        font-size: 12px;
        min-height: 0;
      }

      button:hover {
        background: none;
        box-shadow: none;
        text-shadow: none;
        transition: none;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces button {
        min-width: 16px;
      }

      #workspaces button {
        background: ${colors.inverse.backgroundInactive};
        color: ${colors.inverse.foregroundInactive};
      }

      #workspaces button.focused {
        background: ${colors.inverse.backgroundActive};
        color: ${colors.inverse.foreground};
      }

      #workspaces button.urgent {
        background: ${colors.red};
        color: ${colors.lighterGrey};
      }

      .modules-right {
        background: ${colors.inverse.backgroundInactive};
        color: ${colors.inverse.foreground};
      }

      .modules-right, .modules-right * {
        padding: 0 8px;
      }

      .warning {
        color: ${colors.red};
      }

      #custom-vpn {
        color: ${colors.green};
      }
    '';
  };
}
