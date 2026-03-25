{
  pkgs,
  ...
}:
{
  systemd.user.services.wlsunset = {
    description = "Day/night gamma adjustments";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 47.3 -L 8.5";
      Restart = "on-failure";
    };
  };
}
