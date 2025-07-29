{
  writeShellApplication,
  coreutils,
  findutils,
  gnused,
  menu,
  pass-wayland,
  wl-clipboard,
  jq,
}:

writeShellApplication {
  name = "menu-pass";
  runtimeInputs = [
    coreutils
    findutils
    gnused
    menu
    pass-wayland
    wl-clipboard
    jq
  ];
  text = ''
    id=$(niri msg --json windows | jq '.[] | select(.app_id | test("^menu*")) | .id')
    if [ -n "$id" ]; then
      niri msg action close-window --id="$id"
    fi

    prefix=''${PASSWORD_STORE_DIR:-~/.password-store}
    entry=$(find "$prefix" -name '*.gpg' \
      | sed "s,^$prefix/\(.*\)\.gpg$,\1," \
      | sort \
      | menu --app-id=menu)

    if [ -n "$entry" ]; then
      exec pass show --clip -- "$entry"
    fi
  '';
}
