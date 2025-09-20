{ pkgs, ... }:

{
  # Rust development packages
  packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    git
    curl
    jq
    zsh
  ];

  # Configure Rust environment
  languages.rust = {
    enable = true;
    channel = "stable";
  };

  # Set up environment variables
  env = {
    DEVENV_ACTIVE = "1";
    RUST_BACKTRACE = "1";
  };

  # Shell initialization
  enterShell = ''
    echo "🦀 Rust development environment"
    echo "Rust version: $(rustc --version)"
    echo "Cargo version: $(cargo --version)"
    echo "Working directory: $(pwd)"

    if [ ! -f Cargo.toml ]; then
      echo "💡 No Cargo.toml found. Run 'cargo init' to initialize a new Rust project"
    fi

    echo "✨ Ready for Rust development!"
  '';

  # Pre-commit hooks
  pre-commit.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };
}
