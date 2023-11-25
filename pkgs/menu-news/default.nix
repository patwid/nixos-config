{ writeShellApplication, coreutils, sfeed, wmenu }:

writeShellApplication {
  name = "menu-news";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    url=''$(sfeed_plain "$HOME/.config/sfeed/feeds/"* | sort --reverse |
        wmenu -l 35 -i | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec "$BROWSER" "''${url}"
  '';
}
