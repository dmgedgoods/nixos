# modules/nixos/desktop/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./i3.nix ./audio.nix ];
}
