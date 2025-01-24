{ ... }:
final: prev: {
  whatsapp = prev.webapp.override { name = "whatsapp"; url = "https://web.whatsapp.com"; };
}
