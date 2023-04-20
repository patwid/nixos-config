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
    find "$prefix" -name '*.gpg' \
            | sed "s,^$prefix\(.*\)\.gpg$,\1," \
            | sort \
            | menu \
            | xargs --no-run-if-empty pass show --clip
  '';
}
