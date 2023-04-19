{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  home-manager.users.${user} = {
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

    home.sessionVariables = {
      XDG_SCREENSHOTS_DIR = "/home/${user}/pictures/screenshots";
    };
  };
}
