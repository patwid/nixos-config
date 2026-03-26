{
  lib,
  pkgs,
  ...
}:
{
  systemd.user.services.wlsunset = {
    enable = true;
    description = "Day/night gamma adjustments";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.wlsunset} -l 47.3 -L 8.5";
      Restart = "on-failure";
    };
  };
}
