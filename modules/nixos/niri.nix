{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) colors outputs;
  inherit (config.environment.sessionVariables) XDG_SCREENSHOTS_DIR;
in
{
  imports = [ inputs.nix-wrapper-modules.nixosModules.niri ];

  options = {
    outputs = lib.mkOption {
      type = with lib; types.attrs;
      default = { };
    };
  };

  config = {
    wrappers.niri = {
      enable = true;
      v2-settings = true;
      settings = {
        inherit outputs;

        hotkey-overlay = {
          skip-at-startup = _: { };
        };

        cursor = {
          xcursor-theme = "Adwaita";
          xcursor-size = 24;

          hide-when-typing = _: { };
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

            numlock = _: { };
          };

          touchpad = {
            natural-scroll = _: { };
          };

          warp-mouse-to-focus = _: { };

          focus-follows-mouse = _: {
            props = {
              max-scroll-amount = "0%";
            };
          };
        };

        gestures = {
          hot-corners = {
            off = _: { };
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
            off = _: { };
          };

          border = {
            off = _: { };
          };
        };

        prefer-no-csd = _: { };

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
              on = _: { };
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
          "Mod+T".spawn = "menu-tv";
          "Super+Alt+L".spawn = "swaylock";

          "XF86AudioRaiseVolume" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1.0";
            };
          };
          "XF86AudioLowerVolume" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            };
          };
          "XF86AudioMute" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SINK@"
                "toggle"
              ];
            };
          };
          "XF86AudioMicMute" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SOURCE@"
                "toggle"
              ];
            };
          };

          "XF86MonBrightnessUp" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "brightnessctl"
                "set"
                "20%+"
              ];
            };
          };
          "XF86MonBrightnessDown" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "brightnessctl"
                "set"
                "20%-"
              ];
            };
          };

          "Mod+O" = _: {
            props = {
              repeat = false;
            };
            content = {
              toggle-overview = _: { };
            };
          };

          "Mod+Shift+Q".close-window = _: { };

          "Mod+H".focus-column-left = _: { };
          "Mod+J".focus-window-down = _: { };
          "Mod+K".focus-window-up = _: { };
          "Mod+L".focus-column-right = _: { };

          "Mod+Ctrl+H".move-column-left = _: { };
          "Mod+Ctrl+J".move-window-down = _: { };
          "Mod+Ctrl+K".move-window-up = _: { };
          "Mod+Ctrl+L".move-column-right = _: { };

          "Mod+Home".focus-column-first = _: { };
          "Mod+End".focus-column-last = _: { };
          "Mod+Ctrl+Home".move-column-to-first = _: { };
          "Mod+Ctrl+End".move-column-to-last = _: { };

          "Mod+Shift+H".focus-monitor-left = _: { };
          "Mod+Shift+J".focus-monitor-down = _: { };
          "Mod+Shift+K".focus-monitor-up = _: { };
          "Mod+Shift+L".focus-monitor-right = _: { };

          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };

          "Mod+U".focus-workspace-down = _: { };
          "Mod+I".focus-workspace-up = _: { };
          "Mod+Ctrl+U".move-column-to-workspace-down = _: { };
          "Mod+Ctrl+I".move-column-to-workspace-up = _: { };

          "Mod+Shift+U".move-workspace-down = _: { };
          "Mod+Shift+I".move-workspace-up = _: { };

          "Mod+WheelScrollDown" = _: {
            props = {
              cooldown-ms = 150;
            };
            content = {
              focus-workspace-down = _: { };
            };
          };
          "Mod+WheelScrollUp" = _: {
            props = {
              cooldown-ms = 150;
            };
            content = {
              focus-workspace-up = _: { };
            };
          };
          "Mod+Ctrl+WheelScrollDown" = _: {
            props = {
              cooldown-ms = 150;
            };
            content = {
              move-column-to-workspace-down = _: { };
            };
          };
          "Mod+Ctrl+WheelScrollUp" = _: {
            props = {
              cooldown-ms = 150;
            };
            content = {
              move-column-to-workspace-up = _: { };
            };
          };

          "Mod+WheelScrollRight".focus-column-right = _: { };
          "Mod+WheelScrollLeft".focus-column-left = _: { };
          "Mod+Ctrl+WheelScrollRight".move-column-right = _: { };
          "Mod+Ctrl+WheelScrollLeft".move-column-left = _: { };

          "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
          "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: { };
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: { };

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

          "Mod+BracketLeft".consume-or-expel-window-left = _: { };
          "Mod+BracketRight".consume-or-expel-window-right = _: { };

          "Mod+Comma".consume-window-into-column = _: { };
          "Mod+Period".expel-window-from-column = _: { };

          "Mod+R".switch-preset-column-width = _: { };
          "Mod+Shift+R".switch-preset-window-height = _: { };
          "Mod+Ctrl+R".reset-window-height = _: { };
          "Mod+F".maximize-column = _: { };
          "Mod+Shift+F".fullscreen-window = _: { };

          "Mod+Ctrl+F".expand-column-to-available-width = _: { };

          "Mod+C".center-column = _: { };

          "Mod+Ctrl+C".center-visible-columns = _: { };

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+Space".toggle-window-floating = _: { };
          "Mod+Shift+Space".switch-focus-between-floating-and-tiling = _: { };

          "Mod+W".toggle-column-tabbed-display = _: { };

          "Print".screenshot = _: { };
          "Ctrl+Print".screenshot-screen = _: { };
          "Alt+Print".screenshot-window = _: { };

          "Mod+Escape" = _: {
            props = {
              allow-inhibiting = false;
            };
            content = {
              toggle-keyboard-shortcuts-inhibit = _: { };
            };
          };

          "Mod+Shift+E".quit = _: { };
          "Ctrl+Alt+Delete".quit = _: { };

          "Mod+Shift+P".power-off-monitors = _: { };
        };
      }
      // lib.optionalAttrs (config.appleSilicon.enable) {
        # Asahi workaround: `ls -l /dev/dri`
        debug = {
          render-drm-device = "/dev/dri/renderD128";
        };
      };
    };

    programs.niri = {
      enable = true;
      package = config.wrappers.niri.wrapper;
    };

    programs.bash = {
      loginShellInit = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec niri-session -l >/dev/null 2>&1
        fi
      '';
    };

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs) xwayland-satellite;
    };
  };
}
