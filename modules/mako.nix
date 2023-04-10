{ args, config, ... }:
let
  inherit (args) user;
  inherit (config) colors;
in
{
  home-manager.users.${user} = {
    services.mako = {
      enable = true;
      font = "sans-serif 10";
      icons = false;
      padding = "12";
      width = 320;
      borderSize = 2;
      backgroundColor = "${colors.black}";
      borderColor = "${colors.darkestGrey}";
      progressColor = "over ${colors.red}"; # XXX
      textColor = "${colors.white}";
    };
  };
}
