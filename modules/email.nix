{ args, pkgs, ... }:
let
  inherit (args) user;
  pass = "${pkgs.pass}/bin/pass";
  head = "${pkgs.coreutils}/bin/head";
in
{
  home-manager.users.${user} = {
    accounts.email.accounts.Personal = {
      primary = true;
      realName = "Patrick Widmer";
      address = "patrick.widmer@tbwnet.ch";
      userName = "patrick.widmer@tbwnet.ch";
      imap.host = "imap.tbwnet.ch";
      imap.port = 993;
      smtp.host = "smtp.tbwnet.ch";
      smtp.port = 465;
      passwordCommand = "${pass} mail/tbwnet | ${head} -n 1";
    };

    accounts.email.accounts.Work = {
      flavor = "outlook.office365.com";
      realName = "Patrick Widmer";
      address = "patrick.widmer@ergon.ch";
      userName = "patrick.widmer@ergon.ch";
      imap.host = "outlook.office365.com";
      imap.port = 993;
      smtp.host = "smtp.office365.com";
      smtp.port = 587;
      smtp.tls.useStartTls = true;
      passwordCommand = "${pass} work/sso | ${head} -n 1";
    };
  };
}
