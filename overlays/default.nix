{ nur, lib, ... }@attrs:
[ nur.overlay ]
++ map (p: import ./${p} attrs) (lib.filter (n: n != "default.nix") (lib.attrNames (builtins.readDir ./.)))
