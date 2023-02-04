{ config, lib, pkgs, home-manager, ... }:

let
  user = "patwid";
  colors = {
    black = "#181818";
    darkestGrey = "#282828";
    darkerGrey = "#383838";
    darkGrey = "#585858";
    lightGrey = "#b8b8b8";
    lighterGrey = "#d8d8d8";
    lightestGrey = "#e8e8e8";
    white = "#f8f8f8";
    red = "#ab4642";
    green = "#a1b56c";
    yellow = "#f7ca88";
    blue = "#7cafc2";
    magenta = "#ba8baf";
    cyan = "#86c1b9";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    home-manager.nixosModule
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    keep-outputs = true;
    keep-derivations = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "laptop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "us";

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "docker" "networkmanager" "video" "audio" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    aerc
    chromium
    citrix_workspace
    curl
    dbeaver
    docker-compose
    gnome.adwaita-icon-theme
    imagemagick
    jetbrains.idea-community
    jq
    libreoffice
    mpv
    networkmanager-openvpn
    pavucontrol
    pinentry-gnome
    ripgrep
    unzip
    wget
    xdg-utils
    yt-dlp
    zathura
    zip
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto-mono
    font-awesome
  ];

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Emoji" "Font Awesome" ];
      monospace = [ "Roboto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Adwaita";
  };

  programs.bash = {
    loginShellInit = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
        exec sway >/dev/null 2>&1
      fi
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        let g:netrw_banner=0
        set clipboard=unnamedplus
        set guicursor+=a:blinkon700
        set hidden
        set laststatus=1
        set shortmess+=I

        augroup Colors
          autocmd!
          autocmd Syntax * call SetColors()
        augroup END

        function! SetColors() abort
          if &background ==# "dark"
            highlight Directory ctermfg=cyan
            highlight SpecialKey ctermfg=cyan
            highlight Type ctermfg=green
            highlight PreProc ctermfg=blue
          endif
          highlight WinSeparator ctermbg=None
        endfunction
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ editorconfig-vim fugitive vim-nix ];
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      dmenu
      dmenu-wayland
      grim
      mako
      slurp
      swaybg
      swaylock
      wl-clipboard
    ];
    extraSessionCommands = ''
      # export QT_QPA_PLATFORM=wayland
      # export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };

  # programs.chromium.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable = true;
  programs.openvpn3.enable = true;
  programs.xwayland.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Patrick Widmer";
      user.email = "patrick.widmer@tbwnet.ch";
      core.editor = "nvim";
      safe.directory = "/etc/nixos";
    };
    lfs.enable = true;
  };

  services.openssh.enable = true;

  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}/sync";
    configDir = "/home/${user}/.config/syncthing";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.tlp.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  virtualisation.docker.enable = true;

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "${user}" ];
      keepEnv = true;
      persist = true;
    }];
  };

  fileSystems = {
    "/home/${user}/music" = {
      device = "192.168.0.3:/mnt/tank/media/music";
      fsType = "nfs";
      options = [ "nfsvers=3" ];
    };
    "/home/${user}/videos/movies" = {
      device = "192.168.0.3:/mnt/tank/media/movies";
      fsType = "nfs";
      options = [ "nfsvers=3" ];
    };
    "/home/${user}/videos/tv_shows" = {
      device = "192.168.0.3:/mnt/tank/media/tv_shows";
      fsType = "nfs";
      options = [ "nfsvers=3" ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user} = {
    # home.username = "${user}";
    # home.homeDirectory = "/home/${user}";

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
        fonts.size = 9.0;
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
        bars = [{
          fonts.size = 9.0;
          statusCommand = "i3status";
          # stripWorkspaceNumbers = yes;
          position = "top";
          extraConfig = ''
            separator_symbol "  "
            # Diable vertical scrolling (workspaces)
            bindsym button4 nop;
            bindsym button5 nop;
            # Diable horizontal scrolling (workspaces)
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
        }];
      };
      extraConfig = ''
        titlebar_border_thickness 0
        titlebar_padding 2
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
        "volume master" = {
          position = 4;
          settings = {
            format = " %volume";
            format_muted = " muted";
            device = "pulse";
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
          };
        };
        "tztime date" = {
          position = 6;
          settings.format = "%a, %b %d";
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
      searchEngines = {
        DEFAULT = "https://duckduckgo.com/?q={}&kae=b&kz=-1&kau=-1&kao=-1&kap=-1&kaq=-1&kax=-1&kak=-1&k1=-1";
        aw = "https://wiki.archlinux.org/?search={}";
        g = "https://www.google.com/search?q={}";
        yt = "https://youtube.com/results?search_query={}";
        np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      };
      settings = {
        url.start_pages = [ "about:blank" ];
        url.default_page = "about:blank";
        tabs.mousewheel_switching = false;
        tabs.favicons.show = "pinned";
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
            caret.bg = "${colors.magenta}";
            caret.fg = "${colors.black}";
            caret.selection.bg = "${colors.magenta}";
            caret.selection.fg = "${colors.black}";
            command.bg = "${colors.black}";
            command.fg = "${colors.white}";
            command.private.bg = "${colors.darkestGrey}";
            command.private.fg = "${colors.white}";
            insert.bg = "${colors.green}";
            insert.fg = "${colors.black}";
            normal.bg = "${colors.black}";
            normal.fg = "${colors.white}";
            passthrough.bg = "${colors.blue}";
            passthrough.fg = "${colors.black}";
            private.bg = "${colors.darkestGrey}";
            private.fg = "${colors.white}";
            #progress.bg = "${colors.black}";'white'
            url.error.fg = "${colors.red}";
            url.fg = "${colors.white}";
            url.hover.fg = "${colors.blue}";
            url.success.http.fg = "${colors.white}";
            url.success.https.fg = "${colors.green}";
            url.warn.fg = "${colors.yellow}";
          };
          tabs = {
            bar.bg = "${colors.black}";
            even.bg = "${colors.darkestGrey}";
            even.fg = "${colors.lightGrey}";
            indicator.error = "${colors.red}";
            indicator.start = "${colors.black}";
            indicator.stop = "${colors.green}";
            odd.bg = "${colors.darkGrey}";
            odd.fg = "${colors.lightGrey}";
            pinned.even.bg = "${colors.darkestGrey}";
            pinned.even.fg = "${colors.lightGrey}";
            pinned.odd.bg = "${colors.darkGrey}";
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
    };

    programs.bash.enable = true;
    programs.fzf.enable = true;
    programs.password-store.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "desktop";
      documents = "documents";
      download = "downloads";
      music = "music";
      pictures = "pictures";
      publicShare = "public";
      templates = "templates";
      videos = "videos";
    };

    services.wlsunset = {
      enable = true;
      latitude = "47.3";
      longitude = "8.5";
    };

    services.gpg-agent = {
      defaultCacheTtl = 60480000;
      maxCacheTtl = 60480000;
    };

    home.stateVersion = "${config.system.stateVersion}";
  };

}
