{ args, ... }:
{
  programs.git.enable = true;

  home-manager.users.${args.user} = {
    programs.git = {
      enable = true;
      userName = "Patrick Widmer";
      userEmail = "${args.email}";
      lfs.enable = true;
      extraConfig = {
        core.editor = "nvim";
      };
    };
  };
}
