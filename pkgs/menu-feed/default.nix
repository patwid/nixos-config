{ writeShellApplication, coreutils, sfeed, wmenu, name, opener }:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [ coreutils sfeed wmenu ];
  text = ''
    sfeed_update "$HOME/.config/sfeed/${name}/sfeedrc" || true
    url=''$(sfeed_plain "$HOME/.local/share/sfeed/${name}/feeds/"* | sort --reverse |
        wmenu -l 35 | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec ${opener} "''${url}"
  '';
}
