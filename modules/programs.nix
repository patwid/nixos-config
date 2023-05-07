{ args, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    programs = {
      fzf.enable = true;
      htop.enable = true;
      mpv.enable = true;
      password-store.enable = true;
      yt-dlp.enable = true;
      zathura.enable = true;
    };
  };
}
