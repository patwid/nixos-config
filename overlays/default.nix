{ inputs, lib }:
builtins.readDir ./_default
|> builtins.attrNames
|> map (name: import ./_default/${name} { inherit inputs lib; })
|> lib.composeManyExtensions
