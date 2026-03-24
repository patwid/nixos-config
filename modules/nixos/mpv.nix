{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    builtins.attrValues {
      inherit (pkgs)
        ffmpeg
        mpv
        yt-dlp
        ytm
        ;
    }
    ++ lib.optionals (config.home.enable) (
      builtins.attrValues {
        inherit (pkgs)
          menu-movies
          menu-music
          menu-shows
          ;
      }
    );
}
