# modules/nixos/hardware/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./nvidia.nix ./bluetooth.nix ./power.nix ];

  # Base graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
