# modules/nixos/system/boot.nix

{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable unprivileged user namespaces for Docker/Sandboxing
  boot.kernel.sysctl = { "kernel.unprivileged_userns_clone" = 1; };
}
