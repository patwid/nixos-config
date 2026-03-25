{
  config,
  pkgs,
  ...
}:
let
  inherit (config) user;
  homeDir = "/home/${user.name}";

  userDirsConf = pkgs.writeText "user-dirs.dirs" ''
    XDG_DESKTOP_DIR="${homeDir}/tmp"
    XDG_DOCUMENTS_DIR="${homeDir}/documents"
    XDG_DOWNLOAD_DIR="${homeDir}/downloads"
    XDG_MUSIC_DIR="${homeDir}/music"
    XDG_PICTURES_DIR="${homeDir}/pictures"
    XDG_VIDEOS_DIR="${homeDir}/videos"
  '';
in
{
  environment.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${homeDir}/pictures/screenshots";
  };

  system.activationScripts.xdgUserDirs.text = ''
    mkdir -p "${homeDir}/tmp" "${homeDir}/documents" "${homeDir}/downloads" \
             "${homeDir}/music" "${homeDir}/pictures" "${homeDir}/videos" \
             "${homeDir}/pictures/screenshots"
    chown ${user.name}: "${homeDir}/tmp" "${homeDir}/documents" "${homeDir}/downloads" \
                         "${homeDir}/music" "${homeDir}/pictures" "${homeDir}/videos" \
                         "${homeDir}/pictures/screenshots"
    install -Dm644 -o ${user.name} -g users ${userDirsConf} "${homeDir}/.config/user-dirs.dirs"
  '';
}
