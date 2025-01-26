{ lib, ... }@inputs:
self: super:
let
  inherit (super) jetbrains;

  idea-ultimate = jetbrains.idea-ultimate.override {
    vmopts = ''
      -Dawt.toolkit.name=WLToolkit
    '' + lib.optionalString (inputs ? config) inputs.config.ideaExtraVmopts;
  };

  idea-ultimate' = jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ];
in
{
  jetbrains = jetbrains // { idea-ultimate = idea-ultimate'; };
}
