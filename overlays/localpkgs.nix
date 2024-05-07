{ ... }@attrs:
let
  localPkgs = import ../pkgs attrs;
in
self: super:
localPkgs // { vimPlugins = super.vimPlugins.extend (_: _: localPkgs.vimPlugins); }
