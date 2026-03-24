{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user home;
in
{
  home-manager.users.${user.name} = {
    programs = {
      mpv.enable = true;
      yt-dlp.enable = true;
    };

    home.packages =
      with pkgs;
      [
        ffmpeg
        ytm
      ]
      ++ lib.optionals (home.enable) [
        menu-movies
        menu-music
        menu-shows
      ];
  };
}
