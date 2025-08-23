# modules/home-manager/shell/zsh.nix

{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#mack";
      nvf = "nvim /etc/nixos/flake.nix";
    };

    initExtra = ''
      export TERM="xterm-256color"

      # Key bindings for word movement
      bindkey "\\e[1;5C" forward-word
      bindkey "\\e[1;5D" backward-word

      # Autosuggest color change
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=229'

      # Aliases
      alias -- em='emacsclient -t'

      # API keys
      export GEMINI_API_KEY=$(cat /home/mack/.secrets/gemini_api_key)

      # Completion
      autoload -Uz +X compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
    '';
  };
}
