{ config, pkgs, ... }:
let
  inherit (config) user;

  pass = "${pkgs.pass}/bin/pass";
in
{
  home-manager.users.${user.name} = {
    programs.senpai = {
      enable = true;
      config = {
        addr = "chat.sr.ht";
        nick = user.name;

        # address = "chat.sr.ht";
        # nickname = user.name;
        # password-cmd = "${pass} srht/chat";
      };
    };
  };
}
