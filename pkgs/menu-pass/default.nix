{ writeShellApplication
, coreutils
, findutils
, gnused
, wmenu
, pass
, wl-clipboard
}:

writeShellApplication {
  name = "menu-pass";
  runtimeInputs = [ coreutils findutils gnused wmenu pass wl-clipboard ];
  text = ''
    prefix=''${PASSWORD_STORE_DIR:-~/.password-store}
    exec find "$prefix" -name '*.gpg' \
            | sed "s,^$prefix/\(.*\)\.gpg$,\1," \
            | sort \
            | wmenu \
            | xargs --no-run-if-empty pass show --clip
  '';
}
