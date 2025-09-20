{ pkgs, ... }:

{
  # Basic development tools
  packages = with pkgs; [
    git
    curl
    wget
    jq
    zsh
    direnv
  ];

  # Set up environment variables
  env = {
    DEVENV_ACTIVE = "1";
  };

  # Shell initialization
  enterShell = ''
    echo "🔧 Minimal development environment"
    echo "Working directory: $(pwd)"
    echo "✨ Ready for development!"
  '';
}
