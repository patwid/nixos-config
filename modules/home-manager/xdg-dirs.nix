{ config, osConfig, ... }:
let
  inherit (config) home;
  inherit (osConfig) user;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${home.homeDirectory}/tmp";
    documents = "${home.homeDirectory}/documents";
    download = "${home.homeDirectory}/downloads";
    music = "${home.homeDirectory}/music";
    pictures = "${home.homeDirectory}/pictures";
    publicShare = null;
    templates = null;
    videos = "${home.homeDirectory}/videos";
  };

  home.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${home.homeDirectory}/pictures/screenshots";
  };
}
