{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config) user;
  keyFiles = builtins.readDir ../../keys |> lib.attrNames;
in
{
  services.dbus.packages = [ pkgs.gcr ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    settings = {
      default-cache-ttl = 60480000;
      max-cache-ttl = 60480000;
    };
  };

  system.activationScripts.gpgKeyImport.text =
    let
      gpg = "${pkgs.gnupg}/bin/gpg";
      importCmds = lib.concatMapStringsSep "\n" (k: ''
        ${gpg} --homedir "$gpgDir" --batch --import ${../../keys/${k}} 2>/dev/null || true
        # Set ultimate trust: extract fingerprint, pipe ownertrust
        fpr=$(${gpg} --homedir "$gpgDir" --batch --with-colons --import-options show-only --import ${../../keys/${k}} 2>/dev/null | awk -F: '/^fpr/{print $10; exit}')
        if [ -n "$fpr" ]; then
          echo "$fpr:6:" | ${gpg} --homedir "$gpgDir" --batch --import-ownertrust 2>/dev/null || true
        fi
      '') keyFiles;
    in
    ''
      gpgDir="/home/${user.name}/.gnupg"
      mkdir -p "$gpgDir"
      chmod 700 "$gpgDir"
      chown ${user.name}: "$gpgDir"
      ${importCmds}
    '';
}
