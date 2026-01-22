{ pkgs, ... }:
{
  programs.waybar.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) waybar;
  };
}
