{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "/home/${user.name}/documents";
      download = "/home/${user.name}/downloads";
      music = "/home/${user.name}/music";
      pictures = "/home/${user.name}/pictures";
      publicShare = null;
      templates = null;
      videos = "/home/${user.name}/videos";
    };

    home.sessionVariables = {
      XDG_SCREENSHOTS_DIR = "/home/${user.name}/pictures/screenshots";
    };
  };
}
