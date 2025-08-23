# modules/nixos/system/locale.nix

{ config, pkgs, ... }:

{
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
}
