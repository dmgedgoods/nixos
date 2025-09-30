# modules/nixos/system/users.nix

{ config, pkgs, ... }:

{
  users.users.mack = {
    isNormalUser = true;
    description = "mack";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
