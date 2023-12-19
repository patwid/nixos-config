{ nixosConfig, pkgs, ... }:
let
  inherit (nixosConfig) user;

  pass = "${pkgs.pass}/bin/pass";
in
{
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
}
