{
  config,
  ...
}:
let
  inherit (config) user;
  inherit (config.users.users.${user.name}) group;

  homeDir = "/home/${user.name}";
in
{
  environment.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${homeDir}/pictures/screenshots";
  };

  environment.etc."xdg/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="${homeDir}/tmp"
    XDG_DOCUMENTS_DIR="${homeDir}/documents"
    XDG_DOWNLOAD_DIR="${homeDir}/downloads"
    XDG_MUSIC_DIR="${homeDir}/music"
    XDG_PICTURES_DIR="${homeDir}/pictures"
    XDG_VIDEOS_DIR="${homeDir}/videos"
  '';

  environment.etc."xdg/user-dirs.conf".text = ''
    enabled=False
  '';

  system.activationScripts.xdg-dirs.text = ''
    install -d -o ${user.name} -g ${group} ${homeDir}/{tmp,documents,downloads,music,pictures,videos}
  '';
}
