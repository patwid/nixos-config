{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config) user;
  homeDir = "/home/${user.name}";
  gnupgHome = "${homeDir}/.gnupg";

  gpg = lib.getExe pkgs.gnupg;

  keyFiles = builtins.readDir ./keys |> lib.attrNames |> map (k: ./keys/${k});

  keyring = pkgs.runCommand "gpg-keyring" { } ''
    export GNUPGHOME=$(mktemp -d)

    ${lib.concatMapStringsSep "\n" (key: ''
      ${gpg} --import ${key}
      ${gpg} --import-ownertrust <<< \
        "$(${gpg} --with-colons --import-options import-show --dry-run --import ${key} \
          | ${lib.getExe' pkgs.gawk "awk"} -F: '/^fpr/{print $10 ":6:"}')"
    '') keyFiles}

    mkdir $out
    cp $GNUPGHOME/pubring.kbx $out/
    cp $GNUPGHOME/trustdb.gpg $out/
  '';
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

  system.activationScripts.gpg-link-keyring.text = ''
    install -d -o ${user.name} -g users -m 700 ${gnupgHome}
    ln -sf ${keyring}/pubring.kbx ${gnupgHome}/pubring.kbx
    ln -sf ${keyring}/trustdb.gpg ${gnupgHome}/trustdb.gpg
    chown -h ${user.name}:users ${gnupgHome}/pubring.kbx ${gnupgHome}/trustdb.gpg
  '';
}
