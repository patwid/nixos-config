{ args, ... }:
{
  networking.hostName = "${args.hostname}";
}
