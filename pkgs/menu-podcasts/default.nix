{ writeShellApplication, coreutils, sfeed, wmenu }:

writeShellApplication {
  name = "menu-podcasts";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    sfeed_update "$HOME/.config/sfeed/podcasts/sfeedrc" || true
    url=''$(sfeed_plain "$HOME/.config/sfeed/podcasts/feeds/"* | sort --reverse |
        wmenu -l 35 | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec mpv "''${url}"
  '';
}
