# modules/home-manager/development/languages.nix

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python
    uv
    python312
    python312Packages.setuptools
    pyright
    black

    # Go
    go

    # Lua
    lua
    lua-language-server
    stylua

    # Node.js
    nodejs
    prettierd

    # Nix
    nil
    nixfmt-rfc-style

    # C/C++
    gcc
    libgcc
    gdb
    cmake
    extra-cmake-modules
    bear
    vimPlugins.clangd_extensions-nvim
    gnumake
  ];
}
