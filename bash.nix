{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  programs.bash.promptInit = ''
    PS1="\n# "
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
        PS1="\n\$ "
      '';
    };
  };
}
