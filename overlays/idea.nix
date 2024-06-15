{ ... }:
self: super:
let
  inherit (super) jetbrains;

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
