{ lib }:
{
  withoutPrefix = v: lib.strings.removePrefix "#" v;
}
