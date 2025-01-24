{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ himitsu hiprompt-gtk-py ];

  systemd.user.services.himitsu = {
    Unit = {
      Description = "Himitsu daemon";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe' pkgs.himitsu "himitsud";
    };
  };

  xdg.configFile."himitsu/config.ini" = {
    text = lib.generators.toINI { } {
      himitsud = {
        prompter = lib.getExe pkgs.hiprompt-gtk-py;
      };
    };
  };
}
