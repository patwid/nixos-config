{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    himitsu
    hiprompt-gtk
  ];

  systemd.user.services.himitsud = {
    enable = true;
    description = "Himitsu secret storage daemon";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe' pkgs.himitsu "himitsud"}";
      Restart = "on-failure";
      Type = "simple";
    };
  };
}
