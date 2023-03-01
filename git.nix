{ args, ... }:
{
  programs.git.enable = true;

  home-manager.users.${args.user} = {
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
