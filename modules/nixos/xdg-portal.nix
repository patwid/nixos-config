{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = [
      "wlr"
      "gtk"
    ];
  };

  # TODO: necessary?
  # environment.sessionVariables = {
  #   ADW_DISABLE_PORTAL = 1;
  # };
}
