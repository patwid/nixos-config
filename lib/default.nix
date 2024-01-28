(final: prev: {
  colors = import ./colors.nix { lib = prev; };
  inherit (import ./filesystem.nix { lib = prev; }) modulesIn;
})
