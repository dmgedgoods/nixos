{ pkgs, ... }:

{
  # JavaScript development packages
  packages = with pkgs; [
    nodejs_20
    yarn
    pnpm
    git
    curl
    jq
    zsh
  ];

  # Configure JavaScript environment
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_20;
    npm = {
      enable = true;
      install.enable = true;
    };
  };

  # Set up environment variables
  env = {
    DEVENV_ACTIVE = "1";
    NODE_ENV = "development";
  };

  # Shell initialization
  enterShell = ''
    echo "⚡ JavaScript development environment"
    echo "Node.js version: $(node --version)"
    echo "npm version: $(npm --version)"
    echo "yarn version: $(yarn --version)"
    echo "pnpm version: $(pnpm --version)"
    echo "Working directory: $(pwd)"

    if [ ! -f package.json ]; then
      echo "💡 No package.json found. Run one of:"
      echo "  • npm init -y"
      echo "  • yarn init -y"
      echo "  • pnpm init"
    fi

    echo "✨ Ready for JavaScript development!"
  '';

  # Pre-commit hooks
  pre-commit.hooks = {
    prettier.enable = true;
    eslint.enable = true;
  };
}
