{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      himitsu
      hiprompt-gtk-py
    ];

    systemd.user.services.himitsu = {
      Unit = {
        Description = "Himitsu daemon";
        PartOf = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.himitsu}/bin/himitsud";
      };
    };
  };
}
