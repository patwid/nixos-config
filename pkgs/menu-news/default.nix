{ writeShellApplication, coreutils, sfeed, menu }:

writeShellApplication {
  name = "menu-news";
  runtimeInputs = [ coreutils sfeed menu ];
  text = ''
    url=''$(sfeed_plain "$HOME/.config/sfeed/feeds/"* | sort --reverse |
        menu menu-large | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec qutebrowser "''${url}"
  '';
}
