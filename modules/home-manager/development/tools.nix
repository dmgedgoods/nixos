# modules/home-manager/development/tools.nix

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control
    git
    gh

    # Container tools
    docker
    docker-compose

    # CLI tools
    tree
    ripgrep
    fd
    fzf
    btop
    tmux
    fuse
    sshfs

    # AI tools
    gemini-cli
    claude-code

    # Productivity
    obsidian

    # Secrets management
    sops
    age

    # Virtualization stuff
    vmware-workstation
  ];
}
