{ nixpkgs-jbr21, ... }:
self: super:
let

  pkgs = import nixpkgs-jbr21 {
    inherit (super) system;
    config.allowUnfree = super.config.allowUnfree;
  };

  inherit (pkgs) jetbrains;

  idea-ultimate = jetbrains.idea-ultimate.override {
    vmopts = ''
      -Dawt.toolkit.name=WLToolkit
      -Xms4g
      -Xmx4g
    '';
  };

  idea-ultimate' = jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ];
in
{
  jetbrains = jetbrains // { idea-ultimate = idea-ultimate'; };
}
