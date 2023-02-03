{ config, pkgs, home-manager, ... }:

let
  user = "patwid";
  colors = {
    black = "181818";
    darkGrey = "585858";
    lightGrey = "d8d8d8";
    white = "f8f8f8";
    red = "ab4642";
    green = "a1b56c";
    yellow = "f7ca88";
    blue = "7cafc2";
    magenta = "ba8baf";
    cyan = "86c1b9";
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
    curl
    dbeaver
    docker-compose
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
  };

  programs.bash = {
    loginShellInit = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
        exec sway >/dev/null 2>&1
      fi
    '';
    shellAliases = {
      dot = "git --git-dir=/home/${user}/.local/share/dotfiles --work-tree=/etc/nixos";
    };
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
          background = "#ffffff";
          focused = {
            border = "#285577";
            background = "#285577";
            text = "#ffffff";
            indicator = "#285577";
            childBorder = "#285577";
          };
          focusedInactive = {
            border = "#5f676a";
            background = "#5f676a";
            text = "#ffffff";
            indicator = "#5f676a";
            childBorder = "#5f676a";
          };
          unfocused = {
            border = "#222222";
            background = "#222222";
            text = "#888888";
            indicator = "#222222";
            childBorder = "#222222";
          };
          placeholder = {
            border = "#0c0c0c";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#0c0c0c";
            childBorder = "#0c0c0c";
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
            background = "#000000";
            statusline = "#ffffff";
            separator = "#ffffff";
            focusedWorkspace = {
              border = "#000000";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#000000";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#000000";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#000000";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#000000";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }];
      };
    };

    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
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
          foreground = "${colors.lightGrey}";
          background = "${colors.black}";
          regular0 = "${colors.black}";
          regular1 = "${colors.red}";
          regular2 = "${colors.green}";
          regular3 = "${colors.yellow}";
          regular4 = "${colors.blue}";
          regular5 = "${colors.magenta}";
          regular6 = "${colors.cyan}";
          regular7 = "${colors.lightGrey}";
          bright0 = "${colors.darkGrey}";
          bright1 = "${colors.red}";
          bright2 = "${colors.green}";
          bright3 = "${colors.yellow}";
          bright4 = "${colors.blue}";
          bright5 = "${colors.magenta}";
          bright6 = "${colors.cyan}";
          bright7 = "${colors.white}";
        };
      };
    };

    programs.bash.enable = true;
    programs.fzf.enable = true;
    programs.password-store.enable = true;
    programs.qutebrowser.enable = true;

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

    home.stateVersion = "22.11";
  };

}
