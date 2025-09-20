{ pkgs, ... }:

{
  # Define the packages available in the environment
  packages = with pkgs; [
    python3
    uv
  ];

  # Configure the Python environment
  languages.python = {
    enable = true;
    package = pkgs.python3;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  # Set up environment variables
  env = {
    # Ensure pip uses the local environment
    PIP_REQUIRE_VIRTUALENV = "true";
  };

  # Shell initialization
  enterShell = ''
    echo "🐍 Python development environment with uv"
    echo "Python version: $(python --version)"
    echo "uv version: $(uv --version)"

    # Initialize uv project if pyproject.toml doesn't exist
    if [ ! -f pyproject.toml ]; then
      echo "Initializing uv project..."
      uv init --no-readme
      uv add numpy pandas
    fi

    echo "Ready to code! 🚀"
  '';

  # Optional: Pre-commit hooks for code quality
  pre-commit.hooks = {
    black.enable = true;
    isort.enable = true;
    flake8.enable = true;
  };
}
