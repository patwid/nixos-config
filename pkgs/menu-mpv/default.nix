{
  writeShellApplication,
  findutils,
  menu,
  mpv,
  name ? "",
  path ? "",
  depth ? 1,
}:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [
    findutils
    menu
    mpv
  ];
  text = ''
    swaymsg -q [app_id='menu*'] kill || true

    path=$(find ${path} -maxdepth ${builtins.toString depth} -mindepth ${builtins.toString depth} -type d -printf '%P\n' | menu --app-id=menu-fullscreen)

    if [ -n "$path" ]; then
      exec mpv ${path}/"$path"
    fi
  '';
}
