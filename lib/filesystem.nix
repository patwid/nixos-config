{ lib }:
let
  inherit (builtins) toString;
  inherit (lib) filter hasInfix hasSuffix head splitString;
  inherit (lib.filesystem) listFilesRecursive;

  archOf = system: head (splitString "-" system);
  isOptional = path: hasInfix "+" path;
  isArch = { path, arch }: hasInfix "+${arch}" path;
  isImportable = { path, arch }@args: hasSuffix ".nix" path && (!isOptional path || isArch args);
in
{
  modulesIn = system: path:
    listFilesRecursive path
    |> filter (p: isImportable { arch = archOf system; path = toString p; });
}
