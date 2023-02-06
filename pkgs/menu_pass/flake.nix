{
  description = "A passmenu";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = self.packages.x86_64-linux.menu_pass;
    packages.x86_64-linux.menu_pass =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
        pkgs.writeShellScriptBin "menu_pass" ''
          prefix=''${PASSWORD_STORE_DIR:-~/.password-store}
          ${pkgs.findutils}/bin/find "$prefix" -name '*.gpg' \
            | ${pkgs.gnused}/bin/sed "s,^$prefix\(.*\)\.gpg$,\1," \
            | ${pkgs.coreutils}/bin/coreutils --coreutils-prog=sort
        '';
  };
}
