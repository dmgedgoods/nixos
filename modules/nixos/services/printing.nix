# modules/nixos/services/printing.nix

{ config, pkgs, ... }:

{
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
