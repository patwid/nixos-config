{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  gpg = lib.getExe pkgs.gnupg;

  keyring = pkgs.runCommand "gpg-keyring" { } ''
    export GNUPGHOME=$(mktemp -d)

    ${lib.concatMapStringsSep "\n" (key: ''
      ${gpg} --import ${key}
      ${gpg} --import-ownertrust <<< \
        "$(${gpg} --with-colons --import-options import-show --dry-run --import ${key} \
          | ${lib.getExe' pkgs.gawk "awk"} -F: '/^fpr/{print $10 ":6:"}')"
    '') config.publicKeys}

    mkdir $out
    cp $GNUPGHOME/pubring.kbx $out/
    cp $GNUPGHOME/trustdb.gpg $out/
  '';
in
{
  imports = [ wlib.modules.default ];

  options = {
    publicKeys = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
      description = "List of GPG public key files to import into the keyring.";
    };
  };

  config = {
    package = lib.mkDefault pkgs.gnupg;

    flags = lib.mkIf (config.publicKeys != [ ]) {
      "--keyring" = "${keyring}/pubring.kbx";
      "--trustdb-name" = "${keyring}/trustdb.gpg";
    };

    meta.maintainers = [ ];
  };
}
