{ config, pkgs, ... }:
let
  inherit (config) user;

  keyboard = config.home-manager.users.${user.name}
    .wayland.windowManager.sway.config.input."type:keyboard";
in
self: super: {
  cage = super.cage.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.substituteAll {
        src = ./keyboardrepeat.patch;
        inherit (keyboard) repeat_rate repeat_delay;
      })
    ];
  });
}
