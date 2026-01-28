{ inputs, lib }:
./.
|> builtins.readDir
|> builtins.attrNames
|> lib.filter (name: name != "default.nix")
|> map (name: import ./${name} { inherit inputs lib; })
|> lib.composeManyExtensions
