# modules/nixos/services/ssh.nix

{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = { PasswordAuthentication = true; };
  };
}
