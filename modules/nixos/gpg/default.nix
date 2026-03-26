{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config) user;
  homeDir = "/home/${user.name}";
  gnupgHome = "${homeDir}/.gnupg";

  keyFiles =
    builtins.readDir ./keys
    |> lib.attrNames
    |> map (k: ./keys/${k});
in
{
  services.dbus.packages = [ pkgs.gcr ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  environment.etc."gnupg/gpg-agent.conf".text = ''
    default-cache-ttl 60480000
    max-cache-ttl 60480000
  '';

  system.activationScripts.gpg-import-keys.text = ''
    install -d -o ${user.name} -g users -m 700 ${gnupgHome}
    ${lib.concatMapStringsSep "\n" (key: ''
      ${pkgs.gnupg}/bin/gpg --homedir ${gnupgHome} --import ${key}
      ${pkgs.gnupg}/bin/gpg --homedir ${gnupgHome} --import-ownertrust <<< "$(${pkgs.gnupg}/bin/gpg --homedir ${gnupgHome} --with-colons --fingerprint ${key} | ${pkgs.gawk}/bin/awk -F: '/^fpr/{print $10 ":6:"}')"
    '') keyFiles}
    chown -R ${user.name}:users ${gnupgHome}
  '';
}
