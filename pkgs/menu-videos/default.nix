{ writeShellApplication, coreutils, sfeed, wmenu }:

writeShellApplication {
  name = "menu-videos";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    sfeed_update "$HOME/.config/sfeed/videos/sfeedrc" || true
    url=''$(sfeed_plain "$HOME/.config/sfeed/videos/feeds/"* | sort --reverse |
        wmenu -l 35 | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec mpv "''${url}"
  '';
}
