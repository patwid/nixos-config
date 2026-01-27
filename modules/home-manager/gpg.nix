{ lib, pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    publicKeys =
      builtins.readDir ../../keys
      |> lib.attrNames
      |> map (k: {
        source = ../../keys/${k};
        trust = "ultimate";
      });
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
    defaultCacheTtl = 60480000;
    maxCacheTtl = 60480000;
  };
}
