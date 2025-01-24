{ ... }:
final: prev: {
  notify-low-battery = prev.notify.override { name = "notify-low-battery"; summary = "Warning"; body = "Low Battery"; };
}
