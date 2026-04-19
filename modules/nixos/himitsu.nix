{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  himitsu = config.wrappers.himitsu.wrapper;
in
{
  imports = [
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "himitsu";
      value = ./_wrappers/himitsu.nix;
    })
  ];

  wrappers.himitsu = {
    enable = true;
    settings = {
      himitsud = {
        prompter = lib.getExe pkgs.hiprompt-gtk;
      };
    };
  };

  environment.systemPackages = [
    himitsu
    pkgs.hiprompt-gtk
  ];

  systemd.user.services.himitsud = {
    enable = true;
    description = "Himitsu secret storage daemon";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = lib.getExe himitsu;
      Restart = "on-failure";
      Type = "simple";
    };
  };
}
