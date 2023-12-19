{ config, ... }:
let
  inherit (config) user;
in
{
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  home-manager.users.${user.name} = {
    programs.direnv = {
      enable = true;
      config = {
        warn_timeout = "1h";
      };
      nix-direnv.enable = true;
    };
  };
}
