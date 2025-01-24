{ ... }:
final: prev: {
  teams = prev.webapp.override { name = "teams"; url = "https://teams.microsoft.com"; };
}
