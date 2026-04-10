{
  inputs,
  config,
  pkgs,
  ...
}:
let
  keyFiles = builtins.readDir ./keys |> builtins.attrNames |> map (k: ./keys/${k});
in
{
  imports = [
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "gnupg";
      value = ../_wrappers/gnupg.nix;
    })
  ];

  services.dbus.packages = [ pkgs.gcr ];

  wrappers.gnupg = {
    enable = true;
    publicKeys = keyFiles;
  };

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
    package = config.wrappers.gnupg.wrapper;
  };
}
