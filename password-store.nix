{ ... }:
let
  user = import ./user.nix;
in {
  imports = [
    ./gpg.nix
  ];

  home-manager.users.${user} = {
    programs.password-store.enable = true;
  };
}
