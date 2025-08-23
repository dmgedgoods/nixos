{ config, pkgs, ... }:

{
  imports = [ ./applications.nix ];

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

    # Gaming packages (since Steam is configured at system level)
    vulkan-tools
    vulkan-loader
    winetricks
    protontricks

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.hack
    jetbrains-mono
  ];
}
