{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  programs.bash.promptInit = ''
    PS1="\n# "
  '';

  home-manager.users.${user.name} = {
    programs.bash = {
      enable = true;
      initExtra = ''
        export GIT_PS1_SHOWDIRTYSTATE=true
        source /run/current-system/sw/share/bash-completion/completions/git-prompt.sh

        bold="\[$(tput bold)\]"
        red="\[$(tput setaf 1)\]"
        green="\[$(tput setaf 2)\]"
        blue="\[$(tput setaf 4)\]"
        magenta="\[$(tput setaf 5)\]"
        cyan="\[$(tput setaf 6)\]"
        reset="\[$(tput sgr0)\]"

        PS1="''${bold}"
        PS1+="\n''${cyan}\W"
        PS1+="''${blue}\$(__git_ps1 \" ''${reset}''${blue}git:(''${bold}%s''${reset}''${blue})\")"
        PS1+="''${reset}\n\$(if [ \"\$?\" = 0 ]; then printf ''${green}; else printf ''${red}; fi)"
        PS1+="\$"
        PS1+="''${reset} "
      '';
    };
  };
}
