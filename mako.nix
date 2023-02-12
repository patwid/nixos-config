{ ... }:
let
  user = import ./user.nix;
  colors = import ./colors.nix;
in {
  home-manager.users.${user} = {
    programs.mako = {
      enable = true;
      backgroundColor = "${colors.darkerGrey}";
      borderColor = "${colors.darkerGrey}";
      borderSize = 0;
      icons = false;
      progressColor = "over ${colors.red}"; # XXX
      textColor = "${colors.white}";
    };
  };
}
