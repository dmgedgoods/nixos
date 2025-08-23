# modules/nixos/services/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./networking.nix ./printing.nix ./ssh.nix ./virtualization.nix ];
}
