{ config, ... }:
let
  inherit (config) user;
in
{
  programs.git.enable = true;

  home-manager.users.${user.name} = {
    programs.git = {
      enable = true;
      userName = "Patrick Widmer";
      userEmail = "${user.email}";
      lfs.enable = true;
      extraConfig = {
        core.editor = "nvim";
      };
    };
  };
}
