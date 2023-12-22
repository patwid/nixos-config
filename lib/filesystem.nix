{ lib }:
let
  inherit (builtins) toString;
  inherit (lib) filter hasInfix head splitString;
  inherit (lib.filesystem) listFilesRecursive;

  archOf = system: head (splitString "-" system);
  isOptional = path: hasInfix "+" path;
  isArch = { path, arch }: hasInfix "+${arch}" path;
  isImportable = { path, arch }@args: !isOptional path || isArch args;
in
{
  modulesIn = system: path: filter (p: isImportable { arch = archOf system; path = (toString p); })
    (listFilesRecursive path);
}
