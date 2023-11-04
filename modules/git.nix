{ config, args, pkgs, ... }:
let
  inherit (args) user;
  inherit (config) work;
in
{
  programs.git.enable = true;

  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      userName = "Patrick Widmer";
      userEmail =
        if work.enable then
          "patrick.widmer@ergon.ch"
        else
          "patrick.widmer@tbwnet.ch";

      lfs.enable = true;
      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "${pkgs.neovim}/bin/nvim";
      };
    };
  };
}
