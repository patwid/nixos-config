{ osConfig, ... }:
let
  inherit (osConfig) user;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "/home/${user.name}/tmp";
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
}
