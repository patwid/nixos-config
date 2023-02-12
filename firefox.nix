{ ... }:
let
  user = import ./user.nix;
in {
  home-manager.users.${user} = {
    programs.firefox.enable = true;
  };
}
