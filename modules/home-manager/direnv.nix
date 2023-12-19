{ ... }:
{
  programs.direnv = {
    enable = true;
    config = { warn_timeout = "1h"; };
    nix-direnv.enable = true;
  };
}
