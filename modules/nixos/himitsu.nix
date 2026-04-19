{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  himitsu = config.wrappers.himitsu.wrapper;
  hissh-agent = config.wrappers.himitsu-ssh.wrapper;
in
{
  imports = [
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "himitsu";
      value = ./_wrappers/himitsu.nix;
    })
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "himitsu-ssh";
      value = ./_wrappers/himitsu-ssh.nix;
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

  wrappers.himitsu-ssh = {
    enable = true;
    settings = { };
  };

  environment.systemPackages = [
    himitsu
    pkgs.hiprompt-gtk
    hissh-agent
  ];

  environment.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/hissh-agent";

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

  systemd.user.services.hissh-agent = {
    enable = true;
    description = "Himitsu SSH agent";
    partOf = [ "graphical-session.target" ];
    after = [
      "graphical-session.target"
      "himitsud.service"
    ];
    requires = [ "himitsud.service" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = lib.getExe hissh-agent;
      Restart = "on-failure";
      Type = "simple";
    };
  };
}
