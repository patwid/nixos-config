{ lib, pkgs, ... }:
let
  user = import ./user.nix;
  colors = import ./colors.nix;
  modifier = "Mod4";
in {
  imports = [
    ./aerc.nix
    ./bash.nix
    ./chromium.nix
    ./direnv.nix
    ./firefox.nix
    ./foot.nix
    ./git.nix
    ./i3status.nix
    ./local-pkgs.nix
    ./mako.nix
    ./password-store.nix
    ./pipewire.nix
    ./qutebrowser.nix
    ./wlsunset.nix
    ./xdg.nix
  ];

  users.users.${user}.extraGroups = [ "input" "video" "audio" ];

  programs.sway.enable = true;

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      curl
      dmenu
      gnome.adwaita-icon-theme
      grim
      imagemagick
      imv
      jq
      libreoffice
      menu-pass
      menu-run
      mpv
      pavucontrol
      ripgrep
      slurp
      sway-contrib.grimshot
      swaybg
      swaylock
      unzip
      wget
      wl-clipboard
      yt-dlp
      zathura
      zip
    ];

    programs.fzf.enable = true;
    programs.htop.enable = true;

    services.syncthing.enable = true;

    home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
    };

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "${modifier}";
        fonts.size = 9.0;
        menu = "menu-run";
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
            border = "${colors.blue}";
            background = "${colors.blue}";
            text = "${colors.black}";
            indicator = "${colors.blue}";
            childBorder = "${colors.blue}";
          };
          focusedInactive = {
            border = "${colors.darkGrey}";
            background = "${colors.darkGrey}";
            text = "${colors.lightGrey}";
            indicator = "${colors.darkGrey}";
            childBorder = "${colors.darkGrey}";
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
            fonts.size = 9.0;
            statusCommand = "i3status";
            # stripWorkspaceNumbers = yes;
            position = "top";
            extraConfig = ''
              separator_symbol "  "
              # Disable vertical scrolling (workspaces)
              bindsym button4 nop;
              bindsym button5 nop;
              # Disable horizontal scrolling (workspaces)
              bindsym button6 nop;
              bindsym button7 nop;
            '';
            colors = {
              background = "${colors.black}";
              statusline = "${colors.white}";
              separator = "${colors.white}";
              focusedWorkspace = {
                border = "${colors.black}";
                background = "${colors.blue}";
                text = "${colors.black}";
              };
              activeWorkspace = {
                border = "${colors.black}";
                background = "${colors.darkGrey}";
                text = "${colors.lightGrey}";
              };
              inactiveWorkspace = {
                border = "${colors.black}";
                background = "${colors.darkestGrey}";
                text = "${colors.lightGrey}";
              };
              urgentWorkspace = {
                border = "${colors.black}";
                background = "${colors.red}";
                text = "${colors.black}";
              };
              bindingMode = {
                border = "${colors.black}";
                background = "${colors.red}";
                text = "${colors.black}";
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
        keybindings = lib.mkOptionDefault {
          "${modifier}+p" = "exec ${pkgs.menu-pass}/bin/menu-pass";
          "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 20%+";
          "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 20%- && ${pkgs.brightnessctl}/bin/brightnessctl --min-value set 13%";
          "--locked XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 10%+ --limit 1.0";
          "--locked XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 10%-";
          "--locked XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
          "--release Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save output";
          "--release Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area";
          "--release Ctrl+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save active";
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
        titlebar_padding 2
      '';
      extraSessionCommands = ''
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
  };
}
