{ lib }:
let
  arch = system: lib.head (lib.splitString "-" system);
  isOptionalModule = path: lib.hasInfix "+" path;
  isArchModule = { path, system }: lib.hasInfix "+${arch system}" path;
  shouldImportModule = { path, system }@args: !isOptionalModule path || isArchModule args;
in
{
  listModulesRecursively = { path, system }: lib.filter (p: shouldImportModule { inherit system; path = (builtins.toString p); })
    (lib.filesystem.listFilesRecursive path);
}
