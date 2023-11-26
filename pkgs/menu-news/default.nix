{ writeShellApplication, coreutils, sfeed, wmenu }:

writeShellApplication {
  name = "menu-news";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    sfeed_update "$HOME/.config/sfeed/news/sfeedrc" || true
    url=''$(sfeed_plain "$HOME/.config/sfeed/news/feeds/"* | sort --reverse |
        wmenu -l 35 | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec xdg-open "''${url}"
  '';
}
