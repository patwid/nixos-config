{ config, lib, pkgs, ... }:
let
  inherit (config) keyboard;
in
{
  options.outputScales = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  config =
    let
      inherit (config) user colors outputScales;
      modifier = "Mod4";
    in
    {
      users.users.${user.name}.extraGroups = [ "input" "video" "audio" ];

      security.polkit.enable = true;
      hardware.opengl.enable = true;

      home-manager.users.${user.name} = {
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
              "type:mouse" = {
                pointer_accel = "0";
                scroll_factor = "2";
              };
            };
            seat."*" = {
              hide_cursor = "when-typing enable";
              xcursor_theme = "Adwaita";
            };
            output = lib.mapAttrs' (o: s: lib.nameValuePair o { scale = s; }) outputScales;
            colors = {
              background = colors.white;
              focused = {
                border = colors.darkerGrey;
                background = colors.darkerGrey;
                text = colors.white;
                indicator = colors.darkerGrey;
                childBorder = colors.darkerGrey;
              };
              focusedInactive = {
                border = colors.darkestGrey;
                background = colors.darkestGrey;
                text = colors.white;
                indicator = colors.darkestGrey;
                childBorder = colors.darkestGrey;
              };
              unfocused = {
                border = colors.darkestGrey;
                background = colors.darkestGrey;
                text = colors.lightGrey;
                indicator = colors.darkestGrey;
                childBorder = colors.darkestGrey;
              };
              placeholder = {
                border = colors.black;
                background = colors.black;
                text = colors.white;
                indicator = colors.black;
                childBorder = colors.black;
              };
            };
            bars = [
              {
                position = "top";
                fonts = {
                  names = [ "sans-serif" ];
                  size = 9.0;
                };
                statusCommand = "${pkgs.i3status}/bin/i3status";
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
                  background = colors.darkestGrey;
                  statusline = colors.white;
                  separator = colors.white;
                  focusedWorkspace = {
                    border = colors.darkerGrey;
                    background = colors.darkerGrey;
                    text = colors.white;
                  };
                  activeWorkspace = {
                    border = colors.darkestGrey;
                    background = colors.darkestGrey;
                    text = colors.white;
                  };
                  inactiveWorkspace = {
                    border = colors.darkestGrey;
                    background = colors.darkestGrey;
                    text = colors.lightGrey;
                  };
                  urgentWorkspace = {
                    border = colors.red;
                    background = colors.red;
                    text = colors.darkestGrey;
                  };
                  bindingMode = {
                    border = colors.red;
                    background = colors.red;
                    text = colors.darkestGrey;
                  };
                };
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
                # TODO: https://github.com/nix-community/home-manager/pull/4636
                "${modifier}+0" = "workspace number 10";
                "${modifier}+Shift+0" = "move container to workspace number 10";

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
      };
    };
}
