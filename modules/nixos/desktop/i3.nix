# modules/nixos/desktop/i3.nix

{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:swapcaps";
    };
    displayManager = { lightdm.enable = true; };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3blocks ];
    };
  };

  services.displayManager = { defaultSession = "none+i3"; };

  # Screen Locker
  programs.i3lock.enable = true;

  # Libinput
  services.libinput.enable = true;
}
