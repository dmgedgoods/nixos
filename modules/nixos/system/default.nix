# modules/nixos/system/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./boot.nix ./locale.nix ./users.nix ];

  # Global Nix settings
  nix.settings.experimental-features =
    [ "nix-command" "flakes" "impure-derivations" "ca-derivations" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  # System-wide packages
  environment.systemPackages = with pkgs; [ vim wget curl git ];
}
