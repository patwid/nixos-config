{ config, ... }:
self: super:
let
  inherit (config) ideaExtraVmopts;
  inherit (super) jetbrains;

  idea-ultimate = jetbrains.idea-ultimate.override {
    vmopts = ''
      -Dawt.toolkit.name=WLToolkit
    '' + ideaExtraVmopts;
  };

  idea-ultimate' = jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ];
in
{
  jetbrains = jetbrains // { idea-ultimate = idea-ultimate'; };
}
