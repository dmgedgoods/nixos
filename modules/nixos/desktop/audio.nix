# modules/nixos/desktop/audio.nix

{ config, pkgs, ... }:

{
  services.pipewire.enable = true;
  services.pulseaudio.enable = false;
}
