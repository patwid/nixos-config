{ writeShellApplication, findutils, wmenu, mpv, name, dir, depth ? 1 }:

writeShellApplication {
  name = "menu-${name}";
  runtimeInputs = [ findutils wmenu mpv ];
  text = ''
    path=$(find ${dir} -maxdepth ${builtins.toString depth} -mindepth ${builtins.toString depth} -type d -printf '%P\n' | wmenu -l 35)

    if [ -n "$path" ]; then
      exec mpv ${dir}/"$path"
    fi
  '';
}
