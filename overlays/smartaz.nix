{ ... }:
final: prev: {
  smartaz = prev.webapp.override { name = "smartaz"; url = "https://smartaz.ergon.ch"; };
}
