# modules/nixos/hardware/bluetooth.nix

{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;
}
