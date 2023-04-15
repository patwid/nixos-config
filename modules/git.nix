{ args, ... }:
let
  inherit (args) user email;
in
{
  programs.git.enable = true;

  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      userName = "Patrick Widmer";
      userEmail = "${email}";
      lfs.enable = true;
      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "nvim";
      };
    };
  };
}
