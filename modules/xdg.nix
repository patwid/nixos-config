{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "/home/${user}/sync/documents";
      download = "/home/${user}/sync/downloads";
      music = "/home/${user}/music";
      pictures = "/home/${user}/sync/pictures";
      publicShare = null;
      templates = null;
      videos = "/home/${user}/videos";
    };
  };
}
