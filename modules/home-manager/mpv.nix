{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) home;
in
{
  programs = {
    mpv.enable = true;
    yt-dlp.enable = true;
  };

  home.packages = with pkgs; [ ffmpeg ] ++
    lib.optionals (home.enable) [
      menu-movies
      menu-music
      menu-shows
    ];
}
