{ writeShellApplication, coreutils, sfeed, menu }:

writeShellApplication {
  name = "menu-videos";
  runtimeInputs = [ coreutils sfeed menu ];
  text = ''
    url=''$(sfeed_plain "$HOME/.config/sfeed/videos/feeds/"* | sort --reverse |
        menu menu-large | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')
    test -n "''${url}" && exec mpv "''${url}"
  '';
}
