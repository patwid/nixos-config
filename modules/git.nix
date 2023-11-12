{ config, pkgs, ... }:
let
  inherit (config) user work;
in
{
  programs.git.enable = true;

  home-manager.users.${user.name} = {
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
        rerere.enabled = true;
      };
    };
  };
}
