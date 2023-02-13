{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  home-manager.users.${user} = {
    programs.bash = {
      enable = true;
      profileExtra = ''
        if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
          exec ${pkgs.sway}/bin/sway >/dev/null 2>&1
        fi
      '';
      initExtra = ''
        source /run/current-system/sw/share/bash-completion/completions/git-prompt.sh

        bold="\[$(tput bold)\]"
        red="\[$(tput setaf 1)\]"
        green="\[$(tput setaf 2)\]"
        blue="\[$(tput setaf 4)\]"
        magenta="\[$(tput setaf 5)\]"
        cyan="\[$(tput setaf 6)\]"
        reset="\[$(tput sgr0)\]"

        PS1="''${bold}"
        PS1+="\n''${blue}\W"
        PS1+="''${magenta}\$(__git_ps1 \" git:(%s)\") "
        PS1+="\$(if [ \$? == 0 ]; then printf ''${green}; else printf ''${red}; fi)"
        PS1+="\$"
        PS1+="''${reset} "
      '';
    };
  };
}
