{ inputs, config, pkgs, ... }:
let
  inherit (inputs) wrappers;
  inherit (config) colors;
in
wrappers.wrapperModules.waybar.wrap {
  inherit pkgs;

  settings = {
    mainBar = {
      ipc = true;

      modules-left = [
        "niri/workspaces"
      ];
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
        format-warning = "CPU {load}";
        states = {
          warning = 75;
        };
      };

      memory = {
        format = "";
        format-warning = "MEM {avail}G";
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
        format = "BAT {capacity}%";
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

  "style.css".content = ''
    * {
      border-radius: 0;
      border: none;
      font-family: 'monospace';
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
      background: ${colors.backgroundInactive};
    }

    #workspaces button {
      min-width: 16px;
    }

    #workspaces button {
      background: ${colors.backgroundInactive};
      color: ${colors.foregroundInactive};
    }

    #workspaces button.focused {
      background: ${colors.backgroundActive};
      color: ${colors.foreground};
    }

    #workspaces button.urgent {
      background: ${colors.red};
      color: ${colors.lighterGrey};
    }

    .modules-right, #mode {
      background: ${colors.backgroundInactive};
      color: ${colors.foreground};
    }

    .modules-right, .modules-right *, #mode {
      padding: 0 8px;
    }

    .warning {
      color: ${colors.red};
    }

    #custom-vpn {
      color: ${colors.green};
    }
  '';
}
