{ writeShellApplication, coreutils, sfeed, menu, name, opener }:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [ coreutils sfeed menu ];
  text = ''
    swaymsg -q [app_id='menu*'] kill || true

    cfg=$HOME/.local/share/sfeed/${name}
    sfeed_update "$cfg/sfeedrc" || true
    url=$(sfeed_plain "$cfg/feeds/"* \
      | sort --reverse \
      | menu --app-id=menu-fullscreen \
      | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')

    if [ -n "$url" ]; then
      exec ${opener} "$url"
    fi
  '';
}
