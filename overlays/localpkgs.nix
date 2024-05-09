{ ... }@inputs:
let
  localPkgs = import ../pkgs inputs;
in
self: super:
localPkgs // { vimPlugins = super.vimPlugins.extend (_: _: localPkgs.vimPlugins); }
