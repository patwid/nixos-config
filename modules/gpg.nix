{ config, lib, pkgs, ... }:
let
  inherit (config) user;
in
{
  # TODO: https://github.com/nix-community/home-manager/pull/4689
  # Required for pinentry flavor gnome3 to work on non-gnome systems
  services.dbus.packages = [ pkgs.gcr ];

  home-manager.users.${user.name} = {
    home.packages = [ pkgs.pinentry-gnome ];

    programs.gpg = {
      enable = true;
      publicKeys =
        map (k: { source = ../keys/${k}; trust = "ultimate"; })
          (lib.attrNames (builtins.readDir ../keys));
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
