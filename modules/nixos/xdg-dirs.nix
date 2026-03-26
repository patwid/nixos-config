{
  config,
  ...
}:
let
  inherit (config) user;
  homeDir = "/home/${user.name}";
in
{
  environment.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${homeDir}/pictures/screenshots";
  };

  home-manager.users.${user.name} = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${homeDir}/tmp";
      documents = "${homeDir}/documents";
      download = "${homeDir}/downloads";
      music = "${homeDir}/music";
      pictures = "${homeDir}/pictures";
      publicShare = null;
      templates = null;
      videos = "${homeDir}/videos";
    };
  };
}
