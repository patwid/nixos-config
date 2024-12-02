{ osConfig, lib, pkgs, ... }:
let
  inherit (osConfig) work;
in
lib.mkIf (work.enable) {
  home.packages = with pkgs; [
    jtt
    mattermost
    outlook
    smartaz
    teleport_16
    teams
  ];

  # JTT error: No GSettings schemas are installed on the system
  home.sessionVariables = {
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };
}
