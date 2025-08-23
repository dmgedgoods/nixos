# modules/home-manager/editors/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./neovim.nix ];
}
