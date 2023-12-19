{ ... }:
{
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
}
