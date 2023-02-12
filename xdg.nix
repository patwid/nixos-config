{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  home-manager.users.${user} = {
    home.packages = [ pkgs.xdg-utils ];

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "/home/${user}/documents";
      download = "/home/${user}/downloads";
      music = "/home/${user}/music";
      pictures = "/home/${user}/pictures";
      publicShare = null;
      templates = null;
      videos = "/home/${user}/videos";
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
  };
}
