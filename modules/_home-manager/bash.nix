{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      export GIT_PS1_SHOWDIRTYSTATE=true

      source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh

      bold="\[$(tput bold)\]"
      red="\[$(tput setaf 1)\]"
      green="\[$(tput setaf 2)\]"
      blue="\[$(tput setaf 4)\]"
      magenta="\[$(tput setaf 5)\]"
      cyan="\[$(tput setaf 6)\]"
      reset="\[$(tput sgr0)\]"

      PS1="\n"
      PS1+="''${bold}\W\$(__git_ps1 \" git:(%s)\")\n''${reset}"
      PS1+="''${bold}\$''${reset} "
    '';
  };
}
