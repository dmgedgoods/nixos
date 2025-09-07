# modules/home-manager/editors/vscode.nix

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      enkia.tokyo-night
      vscodevim.vim
      yzhang.markdown-all-in-one
      marp-team.marp-vscode
    ];
  };
}
