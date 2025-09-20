{ pkgs, ... }:

{
  # Data science packages
  packages = with pkgs; [
    python3
    uv
    jupyter
    git
    curl
    jq
    zsh
  ];

  # Configure Python environment for data science
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
    DEVENV_ACTIVE = "1";
    JUPYTER_PATH = "${pkgs.jupyter}/bin";
  };

  # Shell initialization
  enterShell = ''
    echo "📊 Data Science development environment"
    echo "Python version: $(python --version)"
    echo "uv version: $(uv --version)"
    echo "Jupyter version: $(jupyter --version)"
    echo "Working directory: $(pwd)"

    if [ ! -f pyproject.toml ]; then
      echo "🔧 No pyproject.toml found. Initializing data science project..."
      uv init --no-readme
      echo "📦 Installing data science packages..."
      uv add numpy pandas matplotlib seaborn scikit-learn jupyter ipykernel plotly
      echo "🪐 Installing Jupyter kernel..."
      uv run python -m ipykernel install --user --name $(basename $(pwd))
    else
      echo "📦 Syncing dependencies..."
      uv sync
    fi

    echo "🚀 Start Jupyter: jupyter lab or jupyter notebook"
    echo "✨ Ready for data science!"
  '';

  # Services for data science
  services = {
    jupyter = {
      enable = true;
      ip = "127.0.0.1";
      port = 8888;
    };
  };

  # Pre-commit hooks
  pre-commit.hooks = {
    black.enable = true;
    isort.enable = true;
  };
}
