{
  imports = map (m: ./. + "/${m}") (builtins.filter (m: m != "default.nix") (builtins.attrNames (builtins.readDir ./.)));
}
