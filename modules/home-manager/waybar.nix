{ nixosConfig, config, ... }:
let
  inherit (nixosConfig) colors laptop;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
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
          all-outputs = true;
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
          format = "";
          format-warning = "BAT  {capacity}%";
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

      #workspaces button, #mode, #cpu, #memory, #custom-vpn, #battery, #clock {
        background: ${colors.inverse.backgroundInactive};
        color: ${colors.inverse.foreground};
      }

      #workspaces button {
        min-width: 20px;
      }

      #workspaces button.focused {
        background: ${colors.inverse.backgroundActive};
        color: ${colors.inverse.foreground};
      }

      #workspaces button.urgent {
        background: ${colors.red};
        color: ${colors.lighterGrey};
      }

      #mode, #cpu, #memory, #custom-vpn, #battery, #clock {
        padding: 0 8px;
      }

      #cpu.warning, #memory.warning, #battery.warning {
        color: ${colors.red};
      }

      #custom-vpn {
        color: ${colors.green};
      }
    '';
  };
}
