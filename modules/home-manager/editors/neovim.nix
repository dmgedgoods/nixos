# modules/home-manager/editors/neovim.nix

{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      lua-language-server
      nil
      stylua
      python312Packages.mdformat
      pyright
      black
      nixfmt
      prettierd
    ];
  };
}
