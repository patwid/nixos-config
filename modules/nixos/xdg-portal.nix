{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config.common.default = [
      "gnome"
      "gtk"
    ];
  };

  # Required by gnome file-chooser
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) nautilus;
  };

  # TODO: necessary?
  # environment.sessionVariables = {
  #   ADW_DISABLE_PORTAL = 1;
  # };
}
