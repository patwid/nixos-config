{ pkgs, args, ... }:
{
  home-manager.users.${args.user} = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "/home/${args.user}/sync/documents";
      download = "/home/${args.user}/sync/downloads";
      music = "/home/${args.user}/music";
      pictures = "/home/${args.user}/sync/pictures";
      publicShare = null;
      templates = null;
      videos = "/home/${args.user}/videos";
    };
  };
}
