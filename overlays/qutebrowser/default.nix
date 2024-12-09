{ lib, config, pkgs, ... }:
let
  inherit (config) colors;
in
self: super: {
  qutebrowser = super.qutebrowser.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./lazyloadtab.patch
    ];
  });
}
