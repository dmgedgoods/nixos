# hosts/mack/home.nix

{ pkgs, sops-nix, ... }:

{
  imports = [
    sops-nix.homeManagerModules.sops

    # Home Manager modules
    ../../modules/home-manager/desktop
    ../../modules/home-manager/development
    ../../modules/home-manager/shell
    ../../modules/home-manager/editors

  ];

  home.username = "mack";
  home.homeDirectory = "/home/mack";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
