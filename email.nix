{ pkgs, args, ... }:
{
  home-manager.users.${args.user} = {
    accounts.email.accounts.Personal = {
      primary = true;
      realName = "Patrick Widmer";
      address = "patrick.widmer@tbwnet.ch";
      userName = "patrick.widmer@tbwnet.ch";
      imap.host = "imap.tbwnet.ch";
      imap.port = 993;
      smtp.host = "smtp.tbwnet.ch";
      smtp.port = 465;
      passwordCommand = "pass mail/tbwnet | head -n 1";
    };

    # https://man.sr.ht/~rjarry/aerc/providers/microsoft.md
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
      passwordCommand = "pass work/sso | head -n 1";
    };
  };
}
