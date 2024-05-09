{ nur, lib, ... }@inputs:
[ nur.overlay ]
++ map (p: import ./${p} inputs) (lib.filter (n: n != "default.nix") (lib.attrNames (builtins.readDir ./.)))
