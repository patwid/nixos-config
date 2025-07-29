{
  writeShellApplication,
  coreutils,
  dmenu,
  findutils,
  menu,
  jq,
}:

writeShellApplication {
  name = "menu-run";
  runtimeInputs = [
    coreutils # dmenu_path depends on coreutils (cat)
    dmenu
    findutils
    menu
    jq
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    bin=$(dmenu_path | menu --app-id=menu)

    if [ -n "$bin" ]; then
      exec niri msg action spawn -- "$bin"
    fi
  '';
}

