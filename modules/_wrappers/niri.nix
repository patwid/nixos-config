{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (inputs) wrappers;
  inherit (config) colors outputs;
  inherit (config.environment.sessionVariables) XDG_SCREENSHOTS_DIR;
in
wrappers.wrappedModules.niri.wrap {
  inherit pkgs;

  settings = {
    inherit outputs;

    hotkey-overlay = {
      skip-at-startup = null;
    };

    cursor = {
      xcursor-theme = "Adwaita";
      xcursor-size = 24;

      hide-when-typing = null;
      hide-after-inactive-ms = 3000;
    };

    input = {
      keyboard = {
        xkb = {
          layout = "us";
          variant = "altgr-intl";
          options = "caps:swapescape";
        };

        repeat-delay = 300;
        repeat-rate = 20;

        numlock = null;
      };

      touchpad = {
        natural-scroll = null;
      };

      warp-mouse-to-focus = null;

      focus-follows-mouse = {
        _attrs = {
          max-scroll-amount = "0%";
        };
      };
    };

    gestures = {
      hot-corners = {
        off = null;
      };
    };

    layout = {
      gaps = 0;

      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.5; }
        { proportion = 1.0; }
      ];

      default-column-width = {
        proportion = 1.0;
      };

      focus-ring = {
        off = null;
      };

      border = {
        off = null;
      };
    };

    prefer-no-csd = null;

    screenshot-path = "${XDG_SCREENSHOTS_DIR}/%Y%m%d_%H%M%S%s.png";

    layer-rules = [
      {
        matches = [ { namespace = "^notifications$"; } ];
        block-out-from = "screencast";
      }
    ];

    window-rules = [
      {
        matches = [
          { app-id = "^menu(.*)$"; }
          {
            app-id = "^jetbrains-idea$";
            title = "^Welcome to IntelliJ IDEA$";
          }
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
          { app-id = "^org.pulseaudio.pavucontrol$"; }
        ];

        open-floating = true;
      }
      {
        matches = [
          { app-id = "^foot$"; }
          { app-id = "^org.qutebrowser.qutebrowser$"; }
          { app-id = "^menu(.*)$"; }
          { app-id = "^org.pulseaudio.pavucontrol$"; }
        ];

        border = {
          on = null;
          width = 1;
          active-color = colors.backgroundActive;
          inactive-color = colors.backgroundInactive;
          urgent-color = colors.red;
        };
      }
    ];

    binds = {
      "Mod+Return".spawn = "foot";
      "Mod+D".spawn = "menu-run";
      "Mod+P".spawn = "menu-pass";
      "Super+Alt+L".spawn = "swaylock";

      "XF86AudioRaiseVolume" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1.0";
      };
      "XF86AudioLowerVolume" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
      };
      "XF86AudioMicMute" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
      };

      "XF86MonBrightnessUp" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn = [
          "brightnessctl"
          "set"
          "20%+"
        ];
      };
      "XF86MonBrightnessDown" = {
        _attrs = {
          allow-when-locked = true;
        };
        spawn = [
          "brightnessctl"
          "set"
          "20%-"
        ];
      };

      "Mod+O" = {
        _attrs = {
          repeat = false;
        };
        toggle-overview = null;
      };

      "Mod+Shift+Q".close-window = null;

      "Mod+H".focus-column-left = null;
      "Mod+J".focus-window-down = null;
      "Mod+K".focus-window-up = null;
      "Mod+L".focus-column-right = null;

      "Mod+Ctrl+H".move-column-left = null;
      "Mod+Ctrl+J".move-window-down = null;
      "Mod+Ctrl+K".move-window-up = null;
      "Mod+Ctrl+L".move-column-right = null;

      "Mod+Home".focus-column-first = null;
      "Mod+End".focus-column-last = null;
      "Mod+Ctrl+Home".move-column-to-first = null;
      "Mod+Ctrl+End".move-column-to-last = null;

      "Mod+Shift+H".focus-monitor-left = null;
      "Mod+Shift+J".focus-monitor-down = null;
      "Mod+Shift+K".focus-monitor-up = null;
      "Mod+Shift+L".focus-monitor-right = null;

      "Mod+Shift+Ctrl+H".move-column-to-monitor-left = null;
      "Mod+Shift+Ctrl+J".move-column-to-monitor-down = null;
      "Mod+Shift+Ctrl+K".move-column-to-monitor-up = null;
      "Mod+Shift+Ctrl+L".move-column-to-monitor-right = null;

      "Mod+U".focus-workspace-down = null;
      "Mod+I".focus-workspace-up = null;
      "Mod+Ctrl+U".move-column-to-workspace-down = null;
      "Mod+Ctrl+I".move-column-to-workspace-up = null;

      "Mod+Shift+U".move-workspace-down = null;
      "Mod+Shift+I".move-workspace-up = null;

      "Mod+WheelScrollDown" = {
        _attrs = {
          cooldown-ms = 150;
        };
        focus-workspace-down = null;
      };
      "Mod+WheelScrollUp" = {
        _attrs = {
          cooldown-ms = 150;
        };
        focus-workspace-up = null;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        _attrs = {
          cooldown-ms = 150;
        };
        move-column-to-workspace-down = null;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        _attrs = {
          cooldown-ms = 150;
        };
        move-column-to-workspace-up = null;
      };

      "Mod+WheelScrollRight".focus-column-right = null;
      "Mod+WheelScrollLeft".focus-column-left = null;
      "Mod+Ctrl+WheelScrollRight".move-column-right = null;
      "Mod+Ctrl+WheelScrollLeft".move-column-left = null;

      "Mod+Shift+WheelScrollDown".focus-column-right = null;
      "Mod+Shift+WheelScrollUp".focus-column-left = null;
      "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = null;
      "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = null;

      "Mod+1".focus-workspace = 1;
      "Mod+2".focus-workspace = 2;
      "Mod+3".focus-workspace = 3;
      "Mod+4".focus-workspace = 4;
      "Mod+5".focus-workspace = 5;
      "Mod+6".focus-workspace = 6;
      "Mod+7".focus-workspace = 7;
      "Mod+8".focus-workspace = 8;
      "Mod+9".focus-workspace = 9;
      "Mod+Ctrl+1".move-column-to-workspace = 1;
      "Mod+Ctrl+2".move-column-to-workspace = 2;
      "Mod+Ctrl+3".move-column-to-workspace = 3;
      "Mod+Ctrl+4".move-column-to-workspace = 4;
      "Mod+Ctrl+5".move-column-to-workspace = 5;
      "Mod+Ctrl+6".move-column-to-workspace = 6;
      "Mod+Ctrl+7".move-column-to-workspace = 7;
      "Mod+Ctrl+8".move-column-to-workspace = 8;
      "Mod+Ctrl+9".move-column-to-workspace = 9;

      "Mod+BracketLeft".consume-or-expel-window-left = null;
      "Mod+BracketRight".consume-or-expel-window-right = null;

      "Mod+Comma".consume-window-into-column = null;
      "Mod+Period".expel-window-from-column = null;

      "Mod+R".switch-preset-column-width = null;
      "Mod+Shift+R".switch-preset-window-height = null;
      "Mod+Ctrl+R".reset-window-height = null;
      "Mod+F".maximize-column = null;
      "Mod+Shift+F".fullscreen-window = null;

      "Mod+Ctrl+F".expand-column-to-available-width = null;

      "Mod+C".center-column = null;

      "Mod+Ctrl+C".center-visible-columns = null;

      "Mod+Minus".set-column-width = "-10%";
      "Mod+Equal".set-column-width = "+10%";

      "Mod+Shift+Minus".set-window-height = "-10%";
      "Mod+Shift+Equal".set-window-height = "+10%";

      "Mod+Space".toggle-window-floating = null;
      "Mod+Shift+Space".switch-focus-between-floating-and-tiling = null;

      "Mod+W".toggle-column-tabbed-display = null;

      "Print".screenshot = null;
      "Ctrl+Print".screenshot-screen = null;
      "Alt+Print".screenshot-window = null;

      "Mod+Escape" = {
        _attrs = {
          allow-inhibiting = false;
        };
        toggle-keyboard-shortcuts-inhibit = null;
      };

      "Mod+Shift+E".quit = null;
      "Ctrl+Alt+Delete".quit = null;

      "Mod+Shift+P".power-off-monitors = null;
    };
  }
  // lib.optionalAttrs (config ? appleSilicon && config.appleSilicon.enable) {
    # Asahi workaround: `ls -l /dev/dri`
    debug = {
      render-drm-device = "/dev/dri/renderD128";
    };
  };
}
