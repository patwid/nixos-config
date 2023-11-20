{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    home.packages = [ pkgs.pinentry-gnome ];

    programs.gpg = {
      enable = true;
      publicKeys = [
        { source = ../keys/desktop.pub; trust = "ultimate"; }
        { source = ../keys/laptop.pub; trust = "ultimate"; }
        { source = ../keys/cohen.pub; trust = "ultimate"; }
      ];
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
      defaultCacheTtl = 60480000;
      maxCacheTtl = 60480000;
    };
  };
}
