{ inputs, lib }:
./_default
|> builtins.readDir
|> builtins.attrNames
|> map (name: import ./_default/${name} { inherit inputs lib; })
|> lib.composeManyExtensions
