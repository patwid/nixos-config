{
  writeShellApplication,
  findutils,
  menu,
  mpv,
  name ? "",
  path ? "",
  depth ? 1,
  jq,
}:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [
    findutils
    menu
    mpv
    jq
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    path=$(find ${path} -maxdepth ${builtins.toString depth} -mindepth ${builtins.toString depth} -type d -printf '%P\n' | menu --app-id=menu-fullscreen)

    if [ -n "$path" ]; then
      exec mpv ${path}/"$path"
    fi
  '';
}
