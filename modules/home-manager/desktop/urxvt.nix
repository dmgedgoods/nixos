# nixos/modules/home-manager/desktop/urxvt.nixos

{ pkgs, ... }:

{
  # 1. Install urxvt
  home.packages = with pkgs; [
    rxvt-unicode
  ];

  xresources.properties = {
    "URxvt.transparent" = true;
    "URxvt.shading" = 30;  # 0-100, lower = more transparent
    "URxvt.blurRadius" = 5;  # Optional: adds blur effect

    # Optional: tint the transparency
    "URxvt.tintColor" = "#282828";  # Gruvbox dark background tint

    # Cursor Settings
    "URxvt.cursorColor" = "#d8d8d8";
    "URxvt.cursorBlink" = true;
    "URxvt.cursorUnderline" = false;

    # Font and Spacing
    "URxvt.font" = "xft:monospace:size=11";
    "URxvt.internalBorder" = 10;
    "URxvt.letterSpace" = -1;
    "URxvt.lineSpace" = 0;

    # General Behavior
    "URxvt.scrollBar" = false;
    "URxvt.saveLines" = 2000;

    # Gruvbox Dark Color Scheme
    "URxvt.foreground" = "#d8d8d8";
    "URxvt.color0" = "#282828";
    "URxvt.color8" = "#928374";
    "URxvt.color1" = "#cc241d";
    "URxvt.color9" = "#fb4934";
    "URxvt.color2" = "#98971a";
    "URxvt.color10" = "#b8bb26";
    "URxvt.color3" = "#d79921";
    "URxvt.color11" = "#fabd2f";
    "URxvt.color4" = "#458588";
    "URxvt.color12" = "#83a598";
    "URxvt.color5" = "#b16286";
    "URxvt.color13" = "#d3869b";
    "URxvt.color6" = "#689d6a";
    "URxvt.color14" = "#8ec07c";
    "URxvt.color7" = "#a89984";
    "URxvt.color15" = "#ebdbb2";
	};
}

