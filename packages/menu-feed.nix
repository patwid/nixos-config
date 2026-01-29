{
  lib,
  writeShellApplication,
  coreutils,
  sfeed,
  menu,
  name ? "",
  opener ? null,
  jq,
}:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [
    coreutils
    sfeed
    menu
    jq
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    cfg=$HOME/.local/share/sfeed/${name}
    sfeed_update "$cfg/sfeedrc" || true
    url=$(sfeed_plain "$cfg/feeds/"* \
      | sort --reverse \
      | menu --app-id=menu-fullscreen \
      | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')

    if [ -n "$url" ]; then
      exec ${lib.getExe opener} "$url"
    fi
  '';
}
