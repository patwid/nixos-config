{
  config,
  pkgs,
  lib,
  ...
}:
let
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

  wrappedGnupg = pkgs.symlinkJoin {
    name = "gnupg-wrapped";
    paths = [ pkgs.gnupg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/gpg \
        --add-flags "--keyring ${keyring}/pubring.kbx" \
        --add-flags "--trustdb-name ${keyring}/trustdb.gpg"
    '';
  };
in
{
  services.dbus.packages = [ pkgs.gcr ];

  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      settings = {
        default-cache-ttl = 60480000;
        max-cache-ttl = 60480000;
      };
    };
    package = wrappedGnupg;
  };
}
