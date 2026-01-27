final: prev: {
  colors = import ./colors.nix { lib = prev; };
  filesystem = prev.filesystem // (import ./filesystem.nix { lib = prev; });
}
