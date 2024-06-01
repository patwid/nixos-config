{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) colors keyboard outputScales;
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
        names = [ "sans-serif" ];
        size = 9.0;
      };
      menu = "${pkgs.menu-run}/bin/menu-run";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          xkb_options = "caps:swapescape";
          xkb_numlock = "enabled";
          repeat_delay = builtins.toString keyboard.repeat.delay;
          repeat_rate = builtins.toString keyboard.repeat.rate;
        };
        "type:pointer" = {
          scroll_factor = "3";
        };
        "type:touchpad" = {
          scroll_factor = "3";
        };
      };
      seat."*" = {
        hide_cursor = "when-typing enable";
        xcursor_theme = "Adwaita";
      };
      output = lib.mapAttrs' (o: s: lib.nameValuePair o { scale = s; }) outputScales;
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
          command = "${pkgs.waybar}/bin/waybar";
          position = "top";
          mode = "hide";
        }
      ];
      gaps.smartBorders = "on";
      floating.titlebar = true;
      floating.criteria = [
        { app_id = "^menu$"; }
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
      ];
      keybindings =
        let
          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          grimshot = "${pkgs.sway-contrib.grimshot}/bin/grimshot";
          date = "${pkgs.coreutils}/bin/coreutils --coreutils-prog=date";
          file = "\"$XDG_SCREENSHOTS_DIR\"/$(${date} +%Y%m%d_%H%M%S_%3N).png";
        in
        lib.mkOptionDefault {
          "${modifier}+p" = "exec ${pkgs.menu-pass}/bin/menu-pass";
          "--locked XF86MonBrightnessUp" = "exec ${brightnessctl} set 20%+";
          "--locked XF86MonBrightnessDown" = "exec ${brightnessctl} set 20%-";
          "--locked XF86AudioRaiseVolume" = "exec ${wpctl} set-volume @DEFAULT_SINK@ 10%+ --limit 1.0";
          "--locked XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_SINK@ 10%-";
          "--locked XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_SINK@ toggle";
          "--release Print" = "exec ${grimshot} --notify save output ${file}";
          "--release Shift+Print" = "exec ${grimshot} --notify save area ${file}";
          "--release Ctrl+Print" = "exec ${grimshot} --notify save active ${file}";
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
    '';
    extraSessionCommands = ''
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}
