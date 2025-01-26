{ config, ... }:
let
  inherit (config) keyboard;
in
self: super: {
  cage = super.cage.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (super.substituteAll {
        src = ./keyboardrepeat.patch;
        repeat_rate = keyboard.repeat.rate;
        repeat_delay = keyboard.repeat.delay;
      })
    ];
  });
}
