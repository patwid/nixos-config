{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) colors keyboard output workspaceOutputAssign swayExtraConfig;
  modifier = "Mod4";
in
{
  programs.bash = {
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec sway >/dev/null 2>&1
      fi
    '';
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.base = true;
    systemd.enable = true;
    config = {
      modifier = "${modifier}";
      defaultWorkspace = "workspace number 1";
      fonts = {
        names = [ "monospace" ];
        size = 9.0;
      };
      menu = lib.getExe pkgs.menu-run;
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          xkb_options = "caps:swapescape";
          xkb_numlock = "enabled";
          repeat_delay = builtins.toString keyboard.repeat.delay;
          repeat_rate = builtins.toString keyboard.repeat.rate;
        };
      };
      seat."*" = {
        hide_cursor = "when-typing enable";
        xcursor_theme = "Adwaita";
      };
      inherit workspaceOutputAssign;
      output = output // {
        "*" = { bg = "${colors.blue} solid_color"; };
      };
      colors = {
        background = colors.white; # TODO: usage?
        focused = {
          border = colors.backgroundActive;
          background = colors.backgroundActive;
          text = colors.foreground;
          indicator = colors.backgroundActive;
          childBorder = colors.backgroundActive;
        };
        focusedInactive = {
          border = colors.backgroundInactive;
          background = colors.backgroundInactive;
          text = colors.foreground;
          indicator = colors.backgroundInactive;
          childBorder = colors.backgroundInactive;
        };
        unfocused = {
          border = colors.backgroundInactive;
          background = colors.backgroundInactive;
          text = colors.foregroundInactive;
          indicator = colors.backgroundInactive;
          childBorder = colors.backgroundInactive;
        };
        urgent = {
          border = colors.red;
          background = colors.red;
          text = colors.lighterGrey;
          indicator = colors.red;
          childBorder = colors.red;
        };
        placeholder = {
          border = colors.background;
          background = colors.background;
          text = colors.foreground;
          indicator = colors.background;
          childBorder = colors.background;
        };
      };
      bars = [
        {
          command = lib.getExe pkgs.waybar;
          position = "top";
          mode = "hide";
        }
      ];
      gaps.smartBorders = "on";
      floating.titlebar = true;
      floating.criteria = [
        { app_id = "^menu*$"; }
        { app_id = "^pavucontrol$"; }
      ];
      window.commands = [
        {
          command = "resize set 640 480, border normal";
          criteria.app_id = "^pavucontrol$";
        }
        {
          # Since chromium version 103, when started in application mode
          # (--app=<url>), by default the keyboard seems to be inhibted.
          command = "shortcuts_inhibitor disable";
          criteria.app_id = "^chrome-.*-.*$";
        }
        {
          command = "fullscreen";
          criteria.app_id = "^menu-fullscreen$";
        }
      ];
      keybindings =
        let
          brightnessctl = lib.getExe pkgs.brightnessctl;
          wpctl = lib.getExe' pkgs.wireplumber "wpctl";
          grimshot = lib.getExe pkgs.sway-contrib.grimshot;
          date = lib.getExe' pkgs.coreutils "coreutils" + " --coreutils-prog=date";
          file = "\"$XDG_SCREENSHOTS_DIR\"/$(${date} +%Y%m%d_%H%M%S_%3N).png";
          wlcopy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        in
        lib.mkOptionDefault {
          "${modifier}+Tab" = "workspace next";
          "${modifier}+Shift+Tab" = "workspace prev";
          "${modifier}+p" = "exec ${lib.getExe pkgs.menu-pass}";
          "--locked XF86MonBrightnessUp" = "exec ${brightnessctl} set 20%+";
          "--locked XF86MonBrightnessDown" = "exec ${brightnessctl} set 20%-";
          "--locked XF86AudioRaiseVolume" = "exec ${wpctl} set-mute @DEFAULT_SINK@ 0 && ${wpctl} set-volume @DEFAULT_SINK@ 10%+ --limit 1.0";
          "--locked XF86AudioLowerVolume" = "exec ${wpctl} set-mute @DEFAULT_SINK@ 0 && [ \"$(${wpctl} get-volume @DEFAULT_SINK@ | awk '{print $2}' | tr -d '.')\" -gt \"10\" ] && ${wpctl} set-volume @DEFAULT_SINK@ 10%-";
          "--locked XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_SINK@ toggle";
          "--release Print" = "exec ${wlcopy} < $(${grimshot} --notify save output ${file})";
          "--release Shift+Print" = "exec ${wlcopy} < $(${grimshot} --notify save area ${file})";
          "--release Ctrl+Print" = "exec ${wlcopy} < $(${grimshot} --notify save active ${file})";

          # Disable vertical scrolling (windows)
          "button4" = "nop";
          "button5" = "nop";

          # Disable horizontal scrolling (windows)
          "button6" = "nop";
          "button7" = "nop";
        };
    };
    extraConfig = ''
      titlebar_border_thickness 0
      titlebar_padding 8 2
    '' + swayExtraConfig;
    extraSessionCommands = ''
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}
