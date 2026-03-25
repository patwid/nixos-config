{
  writeShellApplication,
  menu,
  mpv,
  name ? "",
  path ? "",
  jq,
  coreutils,
}:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [
    menu
    mpv
    jq
    coreutils # cut
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    url=$(cat ${path} | menu --app-id=menu-fullscreen | cut -f2)

    if [ -n "$url" ]; then
      exec mpv "$url"
    fi
  '';
}
