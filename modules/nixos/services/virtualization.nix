# modules/nixos/services/virtualization.nix

{ config, pkgs, ... }:

{
  virtualisation.vmware.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;
}
