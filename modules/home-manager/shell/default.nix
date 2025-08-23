# modules/home-manager/shell/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./zsh.nix ./direnv.nix ];
}
