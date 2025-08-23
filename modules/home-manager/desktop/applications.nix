# modules/home-manager/desktop/applications.nix

{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      bash.enable = true;
      global = {
        log_format = "";
        log_filter = "^$";
      };
    };
  };
}
