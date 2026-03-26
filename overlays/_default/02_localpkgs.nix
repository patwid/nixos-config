{ inputs, ... }: _final: prev: inputs.self.packages.${prev.stdenv.hostPlatform.system} or { }
