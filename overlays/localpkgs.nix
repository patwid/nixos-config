{ ... }@attrs:
let
  inherit (import ../pkgs attrs) pkgs vimPlugins;
in
self: super:
pkgs // { vimPlugins = super.vimPlugins.extend (_: _: vimPlugins); }
