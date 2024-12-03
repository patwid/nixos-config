{ writeShellApplication, findutils, menu, mpv, name, dir, depth ? 1 }:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [ findutils menu mpv ];
  text = ''
    swaymsg -q [app_id='menu*'] kill || true

    path=$(find ${dir} -maxdepth ${builtins.toString depth} -mindepth ${builtins.toString depth} -type d -printf '%P\n' | menu --app-id=menu-fullscreen)

    if [ -n "$path" ]; then
      exec mpv ${dir}/"$path"
    fi
  '';
}
