{ args, pkgs, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    programs.mpv.enable = true;
    programs.yt-dlp.enable = true;
  };
}
