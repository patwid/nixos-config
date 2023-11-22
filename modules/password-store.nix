{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_KEY = "6067CCA62DB9F1880EDF9DBC83754340C86D4480,ECA61EE9613C80FF94DB7B5EEF259FB7302DE099,6A94E8F409769CB12BB7D8D43FBB7239935AA3EE";
      };
    };
  };
}
