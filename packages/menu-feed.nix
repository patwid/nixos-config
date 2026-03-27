{
  lib,
  writeShellApplication,
  coreutils,
  sfeed,
  menu,
  name ? "",
  opener ? null,
  sfeedrc ? null,
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

    feeddir=$HOME/.local/share/sfeed/${name}
    sfeed_update ${if sfeedrc != null then sfeedrc else ""} || true
    url=$(sfeed_plain "$feeddir/feeds/"* \
      | sort --reverse \
      | menu --app-id=menu-fullscreen \
      | sed -n 's@^.* \([a-zA-Z]*://\)\(.*\)$@\1\2@p')

    if [ -n "$url" ]; then
      exec ${if opener != null then lib.getExe opener else "false"} "$url"
    fi
  '';
}
