{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  home-manager.users.${user} = {
    programs.aerc.enable = true;
    programs.aerc.extraConfig = {
      general.unsafe-accounts-conf = true;
    };

    accounts.email.accounts = {
      Personal = {
        primary = true;
        realName = "Patrick Widmer";
        address = "patrick.widmer@tbwnet.ch";
        userName = "patrick.widmer@tbwnet.ch";
        imap.host = "imap.tbwnet.ch";
        imap.port = 993;
        smtp.host = "smtp.tbwnet.ch";
        smtp.port = 465;
        passwordCommand = "pass mail/tbwnet | head -n 1";

        aerc.enable = true;
      };
    };
  };
}
