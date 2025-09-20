# modules/home-manager/shell/zsh.nix

{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#mack";
      nvf = "nvim /etc/nixos/flake.nix";

      # DevEnv aliases for quick development environments
      pydev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/python.nix";
      pydevz = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/python.nix -c zsh";
      devinit = "cp /etc/nixos/modules/home-manager/development/dev_templates/python.nix ./devenv.nix && echo 'Created devenv.nix in current directory'";

      # Template selection aliases
      webdev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/web.nix -c zsh";
      datadev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/data.nix -c zsh";
      minimaldev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/minimal.nix -c zsh";
      jsdev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/javascript.nix -c zsh";
      rustdev = "devenv shell --config /etc/nixos/modules/home-manager/development/dev_templates/rust.nix -c zsh";
    };

    initContent = ''
      export TERM="xterm-256color"

      # Key bindings for word movement
      bindkey "\\e[1;5C" forward-word
      bindkey "\\e[1;5D" backward-word

      # Key bindings for word-wise movement and deletion
      bindkey "^[[1;5C" forward-word       # Ctrl + Right Arrow
      bindkey "^[[1;5D" backward-word      # Ctrl + Left Arrow
      bindkey "^H" backward-kill-word      # Ctrl + Backspace
      bindkey "^W" backward-kill-word       # Ctrl + Backspace (alternate code)

      # Autosuggest color change
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=229'

      # Aliases
      alias -- em='emacsclient -t'

      # API keys
      export GEMINI_API_KEY=$(cat /home/mack/.secrets/gemini_api_key)

      # NPM global settings
      export PATH="$HOME/.npm-global/bin:$PATH"

      # Completion
      autoload -Uz +X compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select

      # Function to list available templates
      function devtemplates() {
          echo "📋 Available dev templates:"
          ls -1 /etc/nixos/modules/home-manager/development/dev_templates/*.nix 2>/dev/null | sed 's|.*/||' | sed 's|\.nix$||' | while read template; do
              echo "  • $template"
          done
          echo ""
          echo "Usage: devload <template-name>"
      }

      # Function to load a specific template
      function devload() {
          if [ -z "$1" ]; then
              echo "Usage: devload <template-name>"
              devtemplates
              return 1
          fi

          template_path="/etc/nixos/modules/home-manager/development/dev_templates/$1.nix"

          if [ ! -f "$template_path" ]; then
              echo "❌ Template '$1' not found"
              devtemplates
              return 1
          fi

          echo "🚀 Loading $1 development environment..."
          devenv shell --config "$template_path" -c zsh
      }

      # Function for creating a new project with template selection
      function mkproject() {
          if [ -z "$1" ]; then
              echo "Usage: mkproject <project-name> [template]"
              echo "Available templates:"
              devtemplates
              return 1
          fi

          template="''${2:-python}"
          template_path="/etc/nixos/modules/home-manager/development/dev_templates/$template.nix"

          if [ ! -f "$template_path" ]; then
              echo "❌ Template '$template' not found, using python"
              template_path="/etc/nixos/modules/home-manager/development/dev_templates/python.nix"
          fi

          mkdir -p "$1"
          cd "$1"

          # Copy the selected template
          cp "$template_path" ./devenv.nix

          # Create basic project structure based on template type
          case "$template" in
              "python")
                  uv init --no-readme
                  echo "Adding common dependencies..."
                  uv add numpy pandas requests
                  mkdir -p src tests docs
                  cat > .gitignore << 'EOF'
*.pyc
__pycache__/
.venv/
.devenv/
dist/
build/
*.egg-info/
EOF
                  ;;
              "web"|"javascript")
                  npm init -y
                  mkdir -p src public tests
                  cat > .gitignore << 'EOF'
node_modules/
.devenv/
dist/
build/
.env
.DS_Store
EOF
                  ;;
              "rust")
                  cargo init --name "$1"
                  cat > .gitignore << 'EOF'
/target/
.devenv/
Cargo.lock
*.pdb
EOF
                  ;;
              *)
                  mkdir -p src tests docs
                  echo ".devenv/" > .gitignore
                  ;;
          esac

          echo "# $1" > README.md

          # Initialize git if not already in a repo
          if [ ! -d .git ]; then
              git init
              git add .
              git commit -m "Initial commit"
          fi

          echo "✨ Project '$1' created successfully with $template template!"
          echo "Run 'direnv allow' then 'direnv reload' to activate the environment"
      }

      # Function to setup direnv in current directory
      function setup_direnv() {
          if [ -z "$1" ]; then
              echo "Usage: setup_direnv <template>"
              echo "Available templates:"
              devtemplates
              return 1
          fi

          template_path="/etc/nixos/modules/home-manager/development/dev_templates/$1.nix"

          if [ ! -f "$template_path" ]; then
              echo "❌ Template '$1' not found"
              devtemplates
              return 1
          fi

          # Create .envrc that uses the specified template
          echo "# Use devenv with specified template" > .envrc
          echo "use devenv $template_path" >> .envrc
          echo "" >> .envrc
          echo "# Automatically switch to zsh if available" >> .envrc
          echo 'if command -v zsh >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then' >> .envrc
          echo '    export SHELL=$(which zsh)' >> .envrc
          echo 'fi' >> .envrc

          direnv allow
          echo "✨ Direnv setup complete with $1 template!"
          echo "The environment will auto-activate when you cd into this directory"
      }

      # Function to copy a template to current directory
      function copytemplate() {
          if [ -z "$1" ]; then
              echo "Usage: copytemplate <template-name>"
              devtemplates
              return 1
          fi

          template_path="/etc/nixos/modules/home-manager/development/dev_templates/$1.nix"

          if [ ! -f "$template_path" ]; then
              echo "❌ Template '$1' not found"
              devtemplates
              return 1
          fi

          cp "$template_path" ./devenv.nix
          echo "✅ Copied $1 template to ./devenv.nix"
      }

      # Function to check if we're in a devenv
      function devenv_status() {
          if [ -n "$DEVENV_ACTIVE" ]; then
              echo "🚀 DevEnv is active"
              if [ -n "$DEVENV_ROOT" ]; then
                  echo "📁 Root: $DEVENV_ROOT"
              fi
          else
              echo "💤 No DevEnv detected"
          fi
      }

      # Quick project creation aliases
      alias mkpy='mkproject "$1" python'
      alias mkweb='mkproject "$1" web'
      alias mkjs='mkproject "$1" javascript'
      alias mkrust='mkproject "$1" rust'
      alias mkdata='mkproject "$1" data'
    '';
  };
}
