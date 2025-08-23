# modules/nixos/services/networking.nix

{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
}
