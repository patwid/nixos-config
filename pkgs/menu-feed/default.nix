{ writeShellApplication, coreutils, sfeed, wmenu, name, opener }:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    cfg=$HOME/.config/sfeed/${name}
    sfeed_update "$cfg/sfeedrc" || true
    url=''$(sfeed_plain "$cfg/feeds/"* | sort --reverse | wmenu -l 35 |
        sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec ${opener} "''${url}"
  '';
}
