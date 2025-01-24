{ ... }:
final: prev: {
  outlook = prev.webapp.override { name = "outlook"; url = "https://outlook.office.com/mail"; };
}
