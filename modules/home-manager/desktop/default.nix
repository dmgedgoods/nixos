{ config, pkgs, ... }:

{
  imports = [ ./applications.nix
	./urxvt.nix
	];

  # Fonts
  fonts.fontconfig.enable = true;

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  # Essential applications
  programs.firefox.enable = true;

  # Desktop environment packages
  home.packages = with pkgs; [
    # Term & WM utils
    alacritty
    wezterm
    pavucontrol
    pulseeffects-legacy
    brightnessctl
    vlc
    picom
    acpi
    sysstat
    iw
    busybox
    ripgrep

    # Communication
    slack
    discord

    # Desktop utilities
    dmenu
    rofi
    xclip
    feh
    emacs
    playerctl
    xfce.thunar
    alsa-utils
    flameshot

    # Media
    rclone


    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.iosevka
    jetbrains-mono
  ];
}
