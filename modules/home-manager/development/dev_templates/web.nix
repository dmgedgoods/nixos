{ pkgs, ... }:

{
  # Web development packages
  packages = with pkgs; [
    nodejs_20
    yarn
    git
    curl
    jq
    zsh
  ];

  # Configure Node.js environment
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
    echo "🌐 Web development environment"
    echo "Node.js version: $(node --version)"
    echo "npm version: $(npm --version)"
    echo "Working directory: $(pwd)"

    if [ ! -f package.json ]; then
      echo "💡 No package.json found. Run 'npm init' to initialize a new project"
      echo "🚀 Popular frameworks: npm create react-app, npm create vue@latest, npm create svelte@latest"
    fi

    echo "✨ Ready for web development!"
  '';

  # Pre-commit hooks for web projects
  pre-commit.hooks = {
    prettier.enable = true;
    eslint.enable = true;
  };
}
