{ ... }:
let
  user = import ./user.nix;
in {
  programs.git.enable = true;

  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      userName = "Patrick Widmer";
      userEmail = "patrick.widmer@tbwnet.ch";
      lfs.enable = true;
      extraConfig = {
        core.editor = "nvim";
      };
    };
  };
}
