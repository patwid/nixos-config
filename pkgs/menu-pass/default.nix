{
  writeShellApplication,
  coreutils,
  findutils,
  gnused,
  menu,
  pass,
  wl-clipboard,
}:

writeShellApplication {
  name = "menu-pass";
  runtimeInputs = [
    coreutils
    findutils
    gnused
    menu
    pass
    wl-clipboard
  ];
  text = ''
    swaymsg -q [app_id='menu*'] kill || true

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
