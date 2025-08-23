# modules/nixos/hardware/power.nix

{ config, pkgs, ... }:

{
  services.acpid.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;
  services.asusd.enable = true;
  programs.rog-control-center.enable = true;
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
}
