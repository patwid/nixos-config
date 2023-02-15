{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  programs.bash.promptInit = ''
    bold="\[$(tput bold)\]"
    red="\[$(tput setaf 1)\]"
    reset="\[$(tput sgr0)\]"
    exit="\$(if [ \$? != 0 ]; then printf ''${red}; fi)"

    PS1="\n''${bold}''${exit}\#''${reset} "
  '';

  home-manager.users.${user} = {
    programs.bash = {
      enable = true;
      profileExtra = ''
        if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
          exec ${pkgs.sway}/bin/sway >/dev/null 2>&1
        fi
      '';
      initExtra = ''
        bold="\[$(tput bold)\]"
        red="\[$(tput setaf 1)\]"
        reset="\[$(tput sgr0)\]"
        exit="\$(if [ \$? != 0 ]; then printf ''${red}; fi)"

        PS1="\n''${bold}''${exit}\$''${reset} "
      '';
    };
  };
}
