# hosts/mack/configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # NixOS modules
    ../../modules/nixos/system
    ../../modules/nixos/desktop
    ../../modules/nixos/hardware
    ../../modules/nixos/services
  ];

  # Host-specific settings
  networking.hostName = "nixos";
}
