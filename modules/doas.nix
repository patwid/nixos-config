{ config, ... }:
let
  inherit (config) user;
in
{
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "${user.name}" ];
      keepEnv = true;
      persist = true;
    }];
  };
}
