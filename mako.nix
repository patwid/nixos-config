{ ... }:
let
  user = import ./user.nix;
  colors = import ./colors.nix;
in {
  home-manager.users.${user} = {
    programs.mako = {
      enable = true;
      backgroundColor = "${colors.black}";
      borderColor = "${colors.darkestGrey}";
      borderSize = 2;
      padding = "10";
      icons = false;
      progressColor = "over ${colors.red}"; # XXX
      textColor = "${colors.white}";
    };
  };
}
