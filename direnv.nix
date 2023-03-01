{ args, ... }:
{
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  home-manager.users.${args.user} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
