{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user} = {
    accounts.email.accounts.Personal = {
      aerc.enable = true;
    };

    # # https://man.sr.ht/~rjarry/aerc/providers/microsoft.md
    # accounts.email.accounts.Work = {
    #   aerc.enable = true;
    #   aerc.smtpAuth = "xoauth2";
    # };

    programs.aerc = {
      enable = true;
      extraConfig = {
        general.unsafe-accounts-conf = true;
      };
    };
  };
}
