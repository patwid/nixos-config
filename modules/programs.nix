{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
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
