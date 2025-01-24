{ ... }:
final: prev: {
  mattermost = prev.webapp.override { name = "mattermost"; url = "https://mattermost.ergon.ch"; };
}
