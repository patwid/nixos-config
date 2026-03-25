{
  pkgs,
  ...
}:
{
  environment.defaultPackages = [ ];

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      adwaita-icon-theme
      curl
      fzf
      grim
      htop
      imagemagick
      imv
      jq
      libreoffice-fresh
      man-pages
      man-pages-posix
      menu-pass
      menu-run
      pavucontrol
      ripgrep
      slurp
      swaybg
      telegram-web
      unzip
      wget
      whatsapp
      wl-clipboard
      xdg-open
      zathura
      zip
      ;
  };

  programs.bash.interactiveShellInit = ''
    eval "$(${pkgs.fzf}/bin/fzf --bash)"
  '';
}
