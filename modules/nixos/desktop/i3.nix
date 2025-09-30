# modules/nixos/desktop/i3.nix

{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:swapcaps";
    };
    displayManager = { 
      lightdm = {
        enable = true;
	greeters = {
	  slick = {
	    enable = true;
	    draw-user-backgrounds = true;
	  };
	};
      }; 
    };
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
