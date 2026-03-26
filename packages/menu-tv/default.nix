{
  writeShellApplication,
  menu,
  mpv,
  socat,
  jq,
  coreutils,
}:

let
  menu' = menu.override { fzfOpts = "--with-nth=1 --delimiter='\t'"; };
  channels = builtins.path { name = "channels-tv"; path = ./channels.txt; };
  socketPath = "/tmp/mpv-menu-tv.sock";
in
writeShellApplication {
  name = "menu-tv";
  runtimeInputs = [
    menu'
    mpv
    socat
    jq
    coreutils # cut
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    url=$(cat ${channels} | menu --app-id=menu-fullscreen | cut -f2)

    if [ -n "$url" ]; then
      if [ -S "${socketPath}" ] && echo '{"command":["get_property","pid"]}' | socat - UNIX-CONNECT:${socketPath} >/dev/null 2>&1; then
        echo "{\"command\":[\"loadfile\",\"$url\"]}" | socat - UNIX-CONNECT:${socketPath}
      else
        rm -f ${socketPath}
        exec mpv --input-ipc-server=${socketPath} "$url"
      fi
    fi
  '';
}
