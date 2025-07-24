{ lib, osConfig, config, ... }:
let
  inherit (osConfig) colors output;
  inherit (config) home;

  formatOutputs = builtins.attrNames output |> lib.concatMapStringsSep "\n\n" formatOutput;

  formatOutput = name: ''
    output "${name}" {
        ${format "scale" output.${name}}
        ${formatPosition output.${name}}
    }
  '';

  formatPosition =
    output:
    lib.optionalString (output ? position) (
      let
        position = builtins.split " " output.position;
      in
      "position x=${lib.head position} y=${lib.last position}"
    );

  format = name: output: lib.optionalString (output ? ${name}) "${name} ${output.${name}}";
in
{
  programs.bash = {
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec niri-session -l >/dev/null 2>&1
      fi
    '';
  };

  xdg.configFile."niri/config.kdl".text = ''
    hotkey-overlay {
        skip-at-startup
    }

    cursor {
        xcursor-theme "Adwaita"
        xcursor-size 24

        hide-when-typing
        hide-after-inactive-ms 3000
    }

    input {
        keyboard {
            xkb {
                layout "us"
                variant "altgr-intl"
                options "caps:swapescape"
            }

            repeat-delay 300
            repeat-rate 20

            numlock
        }

        warp-mouse-to-focus
        focus-follows-mouse
    }

    layout {
        gaps 0

        center-focused-column "never"

        preset-column-widths {
            proportion 0.5
            proportion 1.0
        }

        default-column-width { proportion 1.0; }

        focus-ring {
            off
        }

        border {
            off
        }
    }

    gestures {
        hot-corners {
            off
        }
    }

    prefer-no-csd

    screenshot-path "${home.sessionVariables.XDG_SCREENSHOTS_DIR}/%Y%m%d_%H%M%S%s.png"

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        match app-id=r#"^menu(.*)$"#
        open-floating true
    }

    window-rule {
        match is-floating=true
        shadow {
            on
        }
        exclude app-id=r#"^jetbrains-idea$"#
    }

    window-rule {
        match app-id=r#"^(foot|org.qutebrowser.qutebrowser)$"#
        border {
          on
          width 1
          active-color "${colors.backgroundActive}"
          inactive-color "${colors.backgroundInactive}"
          urgent-color "${colors.red}"
        }
    }

    binds {
        Mod+Return { spawn "foot"; }
        Mod+D { spawn "menu-run"; }
        Mod+P { spawn "menu-pass"; }
        Super+Alt+L { spawn "swaylock"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "set" "20%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "20%-"; }

        Mod+O repeat=false { toggle-overview; }

        Mod+Shift+Q { close-window; }

        Mod+H { focus-column-left; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        Mod+L { focus-column-right; }

        Mod+Ctrl+H { move-column-left; }
        Mod+Ctrl+J { move-window-down; }
        Mod+Ctrl+K { move-window-up; }
        Mod+Ctrl+L { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+H { focus-monitor-left; }
        Mod+Shift+J { focus-monitor-down; }
        Mod+Shift+K { focus-monitor-up; }
        Mod+Shift+L { focus-monitor-right; }

        Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L { move-column-to-monitor-right; }

        Mod+U      { focus-workspace-down; }
        Mod+I      { focus-workspace-up; }
        Mod+Ctrl+U { move-column-to-workspace-down; }
        Mod+Ctrl+I { move-column-to-workspace-up; }

        Mod+Shift+U { move-workspace-down; }
        Mod+Shift+I { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+C { center-column; }

        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+Space       { toggle-window-floating; }
        Mod+Shift+Space { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Shift+P { power-off-monitors; }
    }
    ''
    + lib.optionalString (osConfig ? appleSilicon && osConfig.appleSilicon.enable) ''

      // Asahi workaround: `ls -l /dev/dri`
      debug {
          render-drm-device "/dev/dri/renderD128"
      }
    ''
    + formatOutputs;
}
