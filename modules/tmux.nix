{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      baseIndex = 1;
      extraConfig = ''
        set -g status off
      '';
    };
  };
}
