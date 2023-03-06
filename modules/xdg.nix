{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "/home/${user.name}/sync/documents";
      download = "/home/${user.name}/sync/downloads";
      music = "/home/${user.name}/music";
      pictures = "/home/${user.name}/sync/pictures";
      publicShare = null;
      templates = null;
      videos = "/home/${user.name}/videos";
    };
  };
}
