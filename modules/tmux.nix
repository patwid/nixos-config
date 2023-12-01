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
        set -g default-terminal "screen-256color"
        set -g status-style bg=default
        set -g status-right ""
      '';
    };
  };
}
