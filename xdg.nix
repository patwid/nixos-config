{ pkgs, ... }:
let
  user = import ./user.nix;
in {
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
  };
}
