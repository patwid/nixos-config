{ args, config, lib, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) colors;
  modifier = "Mod4";
in
{
  users.users.${user}.extraGroups = [ "input" "video" "audio" ];

  programs.sway.enable = true;

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      gnome.adwaita-icon-theme
      grim
      imv
      libreoffice-fresh
      menu-pass
      menu-run
      pavucontrol
      slurp
      sway-contrib.grimshot
      swaybg
      swaylock
      transmission-gtk
      xdg-open
    ];

    programs.bash = {
      profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec ${pkgs.sway}/bin/sway >/dev/null 2>&1
        fi
      '';
    };

    programs.mpv.enable = true;
    programs.yt-dlp.enable = true;
    programs.zathura.enable = true;

    home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    wayland.windowManager.sway = {
      enable = true;
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
            repeat_delay = "200";
            repeat_rate = "30";
          };
          "type:mouse" = {
            pointer_accel = "0";
            scroll_factor = "2";
          };
        };
        seat."*".hide_cursor = "when-typing enable";
        colors = {
          background = "${colors.white}";
          focused = {
            border = "${colors.darkerGrey}";
            background = "${colors.darkerGrey}";
            text = "${colors.white}";
            indicator = "${colors.darkerGrey}";
            childBorder = "${colors.darkerGrey}";
          };
          focusedInactive = {
            border = "${colors.darkestGrey}";
            background = "${colors.darkestGrey}";
            text = "${colors.white}";
            indicator = "${colors.darkestGrey}";
            childBorder = "${colors.darkestGrey}";
          };
          unfocused = {
            border = "${colors.darkestGrey}";
            background = "${colors.darkestGrey}";
            text = "${colors.lightGrey}";
            indicator = "${colors.darkestGrey}";
            childBorder = "${colors.darkestGrey}";
          };
          placeholder = {
            border = "${colors.black}";
            background = "${colors.black}";
            text = "${colors.white}";
            indicator = "${colors.black}";
            childBorder = "${colors.black}";
          };
        };
        bars = [
          {
            fonts = {
              names = [ "sans-serif" ];
              size = 9.0;
            };
            statusCommand = "${pkgs.i3status}/bin/i3status";
            # stripWorkspaceNumbers = yes;
            position = "top";
            extraConfig = ''
              status_edge_padding 8
              separator_symbol "     "
              # Disable vertical scrolling (workspaces)
              bindsym button4 nop;
              bindsym button5 nop;
              # Disable horizontal scrolling (workspaces)
              bindsym button6 nop;
              bindsym button7 nop;
            '';
            colors = {
              background = "${colors.darkestGrey}";
              statusline = "${colors.white}";
              separator = "${colors.white}";
              focusedWorkspace = {
                border = "${colors.darkerGrey}";
                background = "${colors.darkerGrey}";
                text = "${colors.white}";
              };
              activeWorkspace = {
                border = "${colors.darkestGrey}";
                background = "${colors.darkestGrey}";
                text = "${colors.white}";
              };
              inactiveWorkspace = {
                border = "${colors.darkestGrey}";
                background = "${colors.darkestGrey}";
                text = "${colors.lightGrey}";
              };
              urgentWorkspace = {
                border = "${colors.red}";
                background = "${colors.red}";
                text = "${colors.darkestGrey}";
              };
              bindingMode = {
                border = "${colors.red}";
                background = "${colors.red}";
                text = "${colors.darkestGrey}";
              };
            };
          }
        ];
        floating.titlebar = true;
        floating.criteria = [
          { app_id = "^menu$"; }
          { app_id = "^pavucontrol$"; }
          # { class = "^jetbrains-.*$"; title = "^win0$"; }
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
          in
          lib.mkOptionDefault {
            "${modifier}+0" = "workspace number 10";
            "${modifier}+Shift+0" = "move container to workspace number 10";
            "${modifier}+p" = "exec ${pkgs.menu-pass}/bin/menu-pass";
            "--locked XF86MonBrightnessUp" = "exec ${brightnessctl} set 20%+";
            "--locked XF86MonBrightnessDown" = "exec ${brightnessctl} set 20%-";
            "--locked XF86AudioRaiseVolume" = "exec ${wpctl} set-volume @DEFAULT_SINK@ 10%+ --limit 1.0";
            "--locked XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_SINK@ 10%-";
            "--locked XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_SINK@ toggle";
            "--release Print" = "exec ${grimshot} --notify save output";
            "--release Shift+Print" = "exec ${grimshot} --notify save area";
            "--release Ctrl+Print" = "exec ${grimshot} --notify save active";
            # Diable vertical scrolling (windows)
            "button4" = "nop";
            "button5" = "nop";
            # Diable horizontal scrolling (windows)
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
  };
}
