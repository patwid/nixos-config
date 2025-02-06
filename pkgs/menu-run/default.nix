{
  writeShellApplication,
  coreutils,
  dmenu,
  findutils,
  menu,
}:

writeShellApplication {
  name = "menu-run";
  runtimeInputs = [
    coreutils # dmenu_path depends on coreutils (cat)
    dmenu
    findutils
    menu
  ];
  text = ''
    swaymsg -q [app_id='menu*'] kill || true

    bin=$(dmenu_path | menu --app-id=menu)

    if [ -n "$bin" ]; then
      exec swaymsg exec -- "$bin"
    fi
  '';
}
