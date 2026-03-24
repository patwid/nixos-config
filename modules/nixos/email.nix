{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  pass = lib.getExe pkgs.pass-wayland;
  head = lib.getExe' pkgs.coreutils "head";
in
{
  imports = [
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "aerc";
      value = ./_wrappers/aerc.nix;
    })
  ];

  wrappers.aerc = {
    enable = true;

    settings = {
      general.unsafe-accounts-conf = true;
    };

    accounts = {
      Personal = {
        source = "imaps://patrick.widmer%40tbwnet.ch@imap.tbwnet.ch:993";
        outgoing = "smtps://patrick.widmer%40tbwnet.ch@smtp.tbwnet.ch:465";
        default = "INBOX";
        from = "Patrick Widmer <patrick.widmer@tbwnet.ch>";
        source-cred-cmd = "${pass} mail/tbwnet | ${head} -n 1";
        outgoing-cred-cmd = "${pass} mail/tbwnet | ${head} -n 1";
      };
    };
  };
}
