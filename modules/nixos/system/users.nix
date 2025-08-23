# modules/nixos/system/users.nix

{ config, pkgs, ... }:

{
  users.users.mack = {
    isNormalUser = true;
    description = "mack";
    extraGroups =
      [ "networkmanager" "wheel" "video" "docker" "libvirtd" "kvm" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
