{ pkgs, ... }:
{
  programs = {
    mpv.enable = true;
    yt-dlp.enable = true;
  };

  home.packages = with pkgs; [ ffmpeg ];
}
