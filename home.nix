{ config, lib, pkgs, home-manager, ... }:

let
  user = "patwid";
  colors = import ./colors { };
in {
  imports = [
    home-manager.nixosModule
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # Required for screen sharing to work
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer";

  nixpkgs.overlays =
    let
      localPkgs = import ./pkgs { inherit lib pkgs; };
    in [
      (self: super: {
          menu-run = localPkgs.menu-run;
          menu-pass = localPkgs.menu-pass;
          outlook = localPkgs.outlook;
          smartaz = localPkgs.smartaz;
          teams = localPkgs.teams;
      })
    ];

  home-manager.users.${user} =
    let
      homeDirectory = "/home/${user}";
    in {
      home.username = "${user}";
      home.homeDirectory = "${homeDirectory}";

      home.packages = with pkgs; [
        aerc
        brightnessctl
        chromium
        citrix_workspace
        curl
        dbeaver
        dmenu
        docker-compose
        gnome.adwaita-icon-theme
        grim
        imagemagick
        imv
        jetbrains.idea-ultimate
        jq
        libreoffice
        mattermost
        menu-pass
        menu-run
        mpv
        networkmanager-openvpn
        outlook
        pavucontrol
        pinentry-gnome
        ripgrep
        slurp
        smartaz
        sway-contrib.grimshot
        swaybg
        swaylock
        teams
        unzip
        wget
        wl-clipboard
        xdg-utils
        yt-dlp
        zathura
        zip
      ];

      home.sessionVariables = {
        XCURSOR_THEME = "Adwaita";
        NIXOS_OZONE_WL = "1"; # Enable native wayland support in chromium
      };

      wayland.windowManager.sway =
        let
          modifier = "Mod4";
        in {
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

      programs.i3status = {
        enable = true;
        enableDefault = false;
        general = {
          colors = true;
          color_good = "${colors.green}";
          color_degraded = "${colors.yellow}";
          color_bad = "${colors.red}";
          interval = 5;
        };
        modules = {
          "load" = {
            position = 1;
            settings = {
              format = "";
              format_above_threshold = " %1min";
              max_threshold = 16;
            };
          };
          "memory" = {
            position = 2;
            settings = {
              format = "";
              threshold_degraded = "5G";
              format_degraded = " < %available";
            };
          };
          "path_exists VPN" = {
            position = 3;
            settings = {
              format = " VPN";
              format_down = "";
              path = "/proc/sys/net/ipv4/conf/tun0";
            };
          };
          "battery all" = {
            position = 5;
            settings = {
              format = "%status %percentage";
              format_down = "No battery";
              integer_battery_capacity = true;
              status_chr = "";
              status_bat = "";
              status_unk = "";
              status_full = "";
              path = "/sys/class/power_supply/BAT%d/uevent";
              low_threshold = 10;
              threshold_type = "percentage";
              last_full_capacity = true;
            };
          };
          "tztime date" = {
            position = 6;
            settings.format = "%a, %d %b";
          };
          "tztime time" = {
            position = 7;
            settings.format = "%H:%M ";
          };
        };
      };

      programs.foot = {
        enable = true;
        settings = {
          main.font = "monospace:size=7";
          main.pad = "4x4";
          cursor.blink = "yes";
          colors = {
            foreground = lib.strings.removePrefix "#" "${colors.lighterGrey}";
            background = lib.strings.removePrefix "#" "${colors.black}";
            regular0 = lib.strings.removePrefix "#" "${colors.black}";
            regular1 = lib.strings.removePrefix "#" "${colors.red}";
            regular2 = lib.strings.removePrefix "#" "${colors.green}";
            regular3 = lib.strings.removePrefix "#" "${colors.yellow}";
            regular4 = lib.strings.removePrefix "#" "${colors.blue}";
            regular5 = lib.strings.removePrefix "#" "${colors.magenta}";
            regular6 = lib.strings.removePrefix "#" "${colors.cyan}";
            regular7 = lib.strings.removePrefix "#" "${colors.lighterGrey}";
            bright0 = lib.strings.removePrefix "#" "${colors.darkGrey}";
            bright1 = lib.strings.removePrefix "#" "${colors.red}";
            bright2 = lib.strings.removePrefix "#" "${colors.green}";
            bright3 = lib.strings.removePrefix "#" "${colors.yellow}";
            bright4 = lib.strings.removePrefix "#" "${colors.blue}";
            bright5 = lib.strings.removePrefix "#" "${colors.magenta}";
            bright6 = lib.strings.removePrefix "#" "${colors.cyan}";
            bright7 = lib.strings.removePrefix "#" "${colors.white}";
          };
        };
      };

      programs.qutebrowser = {
        enable = true;
        quickmarks = {
          hm = "https://nix-community.github.io/home-manager/options.html";
          no = "https://nixos.org/manual/nixos/stable/options.html";
          yt = "https://youtube.com";
        };
        searchEngines = {
          DEFAULT = "https://duckduckgo.com/?q={}&kae=b&kz=-1&kau=-1&kao=-1&kap=-1&kaq=-1&kax=-1&kak=-1&k1=-1";
          aw = "https://wiki.archlinux.org/?search={}";
          g = "https://www.google.com/search?q={}";
          no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
          np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
          yt = "https://youtube.com/results?search_query={}";
        };
        settings = {
          url.start_pages = [ "about:blank" ];
          url.default_page = "about:blank";
          tabs.mousewheel_switching = false;
          tabs.favicons.show = "pinned";
          tabs.indicator.width = 0;
          statusbar.widgets = [ "url" "progress" ];
          scrolling.smooth = true;
          # content.cookies.store = false;
          colors = {
            completion = {
              category.bg = "${colors.black}";
              category.border.bottom = "${colors.black}";
              category.border.top = "${colors.black}";
              category.fg = "${colors.lightGrey}";
              even.bg = "${colors.black}";
              fg = "${colors.lightGrey}";
              item.selected.bg = "${colors.blue}";
              item.selected.border.bottom = "${colors.blue}";
              item.selected.border.top = "${colors.blue}";
              item.selected.fg = "${colors.black}";
              item.selected.match.fg = "${colors.black}";
              match.fg = "${colors.lightGrey}";
              odd.bg = "${colors.black}";
              scrollbar.bg = "${colors.black}";
              scrollbar.fg = "${colors.lightGrey}";
            };
            downloads = {
              bar.bg = "${colors.black}";
              error.bg = "${colors.red}";
              error.fg = "${colors.black}";
              start.bg = "${colors.yellow}";
              start.fg = "${colors.black}";
              stop.bg = "${colors.green}";
              stop.fg = "${colors.black}";
            };
            hints.bg = "${colors.yellow}";
            hints.fg = "${colors.black}";
            hints.match.fg = "${colors.darkGrey}";
            # keyhint.bg = 'rgba(0, 0, 0, 80%)'
            keyhint.fg = "${colors.white}";
            keyhint.suffix.fg = "${colors.white}";
            messages = {
              error.bg = "${colors.red}";
              error.border = "${colors.red}";
              error.fg = "${colors.black}";
              info.bg = "${colors.black}";
              info.border = "${colors.black}";
              info.fg = "${colors.white}";
              warning.bg = "${colors.yellow}";
              warning.border = "${colors.yellow}";
              warning.fg = "${colors.black}";
            };
            prompts = {
              bg = "${colors.black}";
              border = "${colors.black}";
              fg = "${colors.white}";
              selected.bg = "${colors.blue}";
              selected.fg = "${colors.black}";
            };
            statusbar = {
              caret.bg = "${colors.black}";
              caret.fg = "${colors.white}";
              caret.selection.bg = "${colors.black}";
              caret.selection.fg = "${colors.white}";
              command.bg = "${colors.black}";
              command.fg = "${colors.white}";
              command.private.bg = "${colors.darkerGrey}";
              command.private.fg = "${colors.white}";
              insert.bg = "${colors.black}";
              insert.fg = "${colors.white}";
              normal.bg = "${colors.black}";
              normal.fg = "${colors.white}";
              passthrough.bg = "${colors.black}";
              passthrough.fg = "${colors.white}";
              private.bg = "${colors.darkerGrey}";
              private.fg = "${colors.white}";
              progress.bg = "${colors.white}";
              url.error.fg = "${colors.white}";
              url.fg = "${colors.white}";
              url.hover.fg = "${colors.white}";
              url.success.http.fg = "${colors.white}";
              url.success.https.fg = "${colors.white}";
              url.warn.fg = "${colors.white}";
            };
            tabs = {
              bar.bg = "${colors.black}";
              even.bg = "${colors.darkestGrey}";
              even.fg = "${colors.lightGrey}";
              indicator.error = "${colors.red}";
              indicator.start = "${colors.black}";
              indicator.stop = "${colors.green}";
              odd.bg = "${colors.darkestGrey}";
              odd.fg = "${colors.lightGrey}";
              pinned.even.bg = "${colors.darkestGrey}";
              pinned.even.fg = "${colors.lightGrey}";
              pinned.odd.bg = "${colors.darkestGrey}";
              pinned.odd.fg = "${colors.lightGrey}";
              pinned.selected.even.bg = "${colors.blue}";
              pinned.selected.even.fg = "${colors.black}";
              pinned.selected.odd.bg = "${colors.blue}";
              pinned.selected.odd.fg = "${colors.black}";
              selected.even.bg = "${colors.blue}";
              selected.even.fg = "${colors.black}";
              selected.odd.bg = "${colors.blue}";
              selected.odd.fg = "${colors.black}";
            };
            webpage.bg = "${colors.white}";
          };
        };
        keyBindings = {
          normal = {
            ",m" = "spawn --detach ${pkgs.mpv}/bin/mpv {url}";
            ",M" = "hint links spawn --detach ${pkgs.mpv}/bin/mpv {hint-url}";
            ";M" = "hint --rapid links spawn --detach ${pkgs.mpv}/bin/mpv {hint-url}";
            ",u" = "spawn ${pkgs.mpv}/bin/umpv {url}";
            ",U" = "hint links spawn ${pkgs.mpv}/bin/umpv {hint-url}";
            ";U" = "hint --rapid links spawn ${pkgs.mpv}/bin/umpv {hint-url}";
          };
        };
      };

      programs.mako = {
        enable = true;
        backgroundColor = "${colors.darkerGrey}";
        borderColor = "${colors.darkerGrey}";
        borderSize = 0;
        icons = false;
        progressColor = "over ${colors.red}"; # XXX
        textColor = "${colors.white}";
      };

      programs.bash = {
        enable = true;
        profileExtra = ''
          if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
            exec ${pkgs.sway}/bin/sway >/dev/null 2>&1
          fi
        '';
        initExtra = ''
          source /run/current-system/sw/share/bash-completion/completions/git-prompt.sh

          bold="\[$(tput bold)\]"
          red="\[$(tput setaf 1)\]"
          green="\[$(tput setaf 2)\]"
          blue="\[$(tput setaf 4)\]"
          magenta="\[$(tput setaf 5)\]"
          cyan="\[$(tput setaf 6)\]"
          reset="\[$(tput sgr0)\]"

          PS1="\n''${bold}"
          PS1+="\$(if [ \$? == 0 ]; then printf ''${green}; else printf ''${red}; fi)"
          PS1+="→ ''${blue}\W"
          PS1+="''${magenta}\$(__git_ps1 \" git:(%s)\")"
          PS1+="''${reset} "
        '';
      };

      programs.git = {
        enable = true;
        userName = "Patrick Widmer";
        userEmail = "patrick.widmer@tbwnet.ch";
        lfs.enable = true;
        extraConfig = {
          core.editor = "nvim";
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      # programs.chromium.enable = true;
      programs.firefox.enable = true;
      programs.htop.enable = true;
      programs.fzf.enable = true;
      programs.password-store.enable = true;

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        documents = "${homeDirectory}/documents";
        download = "${homeDirectory}/downloads";
        music = "${homeDirectory}/music";
        pictures = "${homeDirectory}/pictures";
        publicShare = null;
        templates = null;
        videos = "${homeDirectory}/videos";
      };

      xdg.mimeApps.enable = true;
      xdg.mimeApps.defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
        "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
      };

      services.syncthing.enable = true;

      services.wlsunset = {
        enable = true;
        latitude = "47.3";
        longitude = "8.5";
      };

      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentryFlavor = "gnome3";
        defaultCacheTtl = 60480000;
        maxCacheTtl = 60480000;
      };

      home.stateVersion = "${config.system.stateVersion}";
    };
}
