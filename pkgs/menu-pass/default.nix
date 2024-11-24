{ writeShellApplication
, coreutils
, findutils
, gnused
, menu
, pass
, wl-clipboard
}:

writeShellApplication {
  name = "menu-pass";
  runtimeInputs = [ coreutils findutils gnused menu pass wl-clipboard ];
  text = ''
    prefix=''${PASSWORD_STORE_DIR:-~/.password-store}
    exec pass show --clip -- "$(find "$prefix" -name '*.gpg' \
            | sed "s,^$prefix/\(.*\)\.gpg$,\1," \
            | sort \
            | menu)"
  '';
}
