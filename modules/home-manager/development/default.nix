# modules/home-manager/development/default.nix

{ config, pkgs, ... }:

{
  imports = [ ./languages.nix ./tools.nix ];
}
