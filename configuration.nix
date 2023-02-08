{ config, lib, pkgs, ... }:

let
  user = "patwid";
in {
  imports = [
    ./hardware-configuration.nix
    ./home.nix
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
  boot.cleanTmpDir = true;

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
        start = [
          editorconfig-vim
          fugitive
          vim-nix
        ];
      };
    };
  };

  programs.openvpn3.enable = true;
  programs.sway.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Patrick Widmer";
      user.email = "patrick.widmer@tbwnet.ch";
      safe.directory = "/etc/nixos";
    };
  };

  # Required for pinentry flavor gnome3 to work on non-gnome systems
  services.dbus.packages = [ pkgs.gcr ];

  services.openssh = {
    enable = true;
    settings = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
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

  fileSystems."/home/${user}/music" = {
    device = "192.168.0.3:/mnt/tank/media/music";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
  };

  fileSystems."/home/${user}/videos/movies" = {
    device = "192.168.0.3:/mnt/tank/media/movies";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
  };

  fileSystems."/home/${user}/videos/tv_shows" = {
    device = "192.168.0.3:/mnt/tank/media/tv_shows";
    fsType = "nfs";
    options = [ "nfsvers=3" ];
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

}
