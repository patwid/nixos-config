{ ... }:
let
  user = import ./user.nix;
in {
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  home-manager.users.${user} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
