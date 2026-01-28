{ inputs, lib }:
./.
|> builtins.readDir
|> lib.filterAttrs (name: _: name != "default.nix")
|> builtins.attrNames
|> map (name: import ./${name} { inherit inputs lib; })
|> lib.composeManyExtensions
