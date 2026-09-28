#!/usr/bin/env bash
# Sets up Neovim + tmux from https://github.com/brosell/dotfiles (Ubuntu/Debian).
#
#   curl -fsSL https://raw.githubusercontent.com/brosell/dotfiles/main/setup-dotfiles.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/brosell/dotfiles/main/setup-dotfiles.sh | bash -s -- --no-ruby
set -euo pipefail

# Everything lives in main(), invoked on the last line, so that when piped into
# bash the whole script is read before anything runs (and children reading
# stdin can't swallow the rest of it).
main() {

usage() {
  cat <<'EOF'
Usage: setup-dotfiles.sh [--no-ruby] [--no-deps]
Safe to re-run.
  --no-ruby     skip Ruby + rubocop/erb_lint/solargraph
  --no-deps     skip apt/npm/gem installs (just link configs + install plugins)
EOF
}

REPO_URL="${DOTFILES_REPO:-https://github.com/brosell/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
WITH_RUBY=1
WITH_DEPS=1

for arg in "$@"; do
  case "$arg" in
    --no-ruby) WITH_RUBY=0 ;;
    --no-deps) WITH_DEPS=0 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
  esac
done

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"

link() {
  local src="$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    echo "ok: $dest -> $src"; return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
    echo "backing up $dest -> $backup"
    mv "$dest" "$backup"
  fi
  ln -s "$src" "$dest"
  echo "linked: $dest -> $src"
}

# --- Dependencies -----------------------------------------------------------
if [ "$WITH_DEPS" -eq 1 ]; then
  log "Installing system packages"
  pkgs=(git curl unzip tar gzip build-essential ripgrep fd-find xclip bsdmainutils tmux)
  [ "$WITH_RUBY" -eq 1 ] && pkgs+=(ruby-full)
  $SUDO apt-get update -y
  $SUDO DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkgs[@]}"

  # Debian ships fd as fdfind
  if ! have fd && have fdfind; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  fi

  if ! have nvim; then
    log "Installing Neovim (latest stable) to /opt/nvim"
    arch="$(uname -m)"; [ "$arch" = "aarch64" ] && arch="arm64"
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/nvim.tar.gz" \
      "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz"
    $SUDO rm -rf /opt/nvim
    $SUDO mkdir -p /opt/nvim
    $SUDO tar -xzf "$tmp/nvim.tar.gz" -C /opt/nvim --strip-components=1
    $SUDO ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm -rf "$tmp"
  fi

  if have npm; then
    log "Installing npm tools (prettier, tree-sitter-cli)"
    # Make npm use the node next to it, so the global prefix matches that install
    PATH="$(dirname "$(command -v npm)"):$PATH"
    npm_g="npm install -g"
    # Use sudo only when the global prefix isn't user-writable (e.g. system node)
    [ -w "$(npm prefix -g)/lib" ] || npm_g="$SUDO env PATH=$PATH npm install -g"
    $npm_g prettier tree-sitter-cli
  else
    echo "WARNING: npm not found; install Node.js for prettier, tree-sitter-cli and ts_ls." >&2
  fi

  if [ "$WITH_RUBY" -eq 1 ] && have gem; then
    log "Installing Ruby gems (rubocop, erb_lint, solargraph)"
    $SUDO gem install --no-document rubocop erb_lint solargraph
  fi
fi

# --- Dotfiles ---------------------------------------------------------------
log "Fetching dotfiles into $DOTFILES_DIR"
if [ -d "$DOTFILES_DIR/.git" ]; then
  git -C "$DOTFILES_DIR" pull --ff-only || echo "WARNING: could not fast-forward $DOTFILES_DIR; using current checkout" >&2
else
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

log "Linking configs"
mkdir -p "$CONFIG_DIR"
link "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
link "$DOTFILES_DIR/tmux" "$CONFIG_DIR/tmux"

# --- tmux plugins -----------------------------------------------------------
log "Installing tmux plugins (TPM)"
TPM_DIR="$CONFIG_DIR/tmux/plugins/tpm"
[ -d "$TPM_DIR" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
# install_plugins needs a running tmux server that has sourced the config
tmux -L dotfiles-setup -f "$CONFIG_DIR/tmux/tmux.conf" new-session -d -s setup 2>/dev/null || true
TMUX_PLUGIN_MANAGER_PATH="$CONFIG_DIR/tmux/plugins/" tmux -L dotfiles-setup \
  run-shell "$TPM_DIR/bin/install_plugins" || true
tmux -L dotfiles-setup kill-server 2>/dev/null || true
ls "$CONFIG_DIR/tmux/plugins"

# --- Neovim plugins ---------------------------------------------------------
log "Installing Neovim plugins (lazy.nvim)"
nvim --headless "+Lazy! restore" +qa

log "Installing Treesitter parsers"
nvim --headless -c 'lua require("nvim-treesitter").install({ "typescript", "tsx", "javascript", "lua", "ruby", "html", "json", "markdown" }):wait(300000)' +qa

log "Installing LSP servers / tools via Mason"
wanted=(typescript-language-server html-lsp lua-language-server stylua)
[ "$WITH_RUBY" -eq 1 ] && ! have solargraph && wanted+=(solargraph)
mason_pkgs=()
for p in "${wanted[@]}"; do
  [ -d "$HOME/.local/share/nvim/mason/packages/$p" ] || mason_pkgs+=("$p")
done
if [ "${#mason_pkgs[@]}" -gt 0 ]; then
  nvim --headless -c "MasonInstall ${mason_pkgs[*]}" +qa
else
  echo "all Mason packages already installed"
fi

log "Done"
cat <<'EOF'
Next steps:
  * Use a Nerd Font in your terminal (icons in neo-tree/lualine/alpha).
  * Start tmux and nvim; run :checkhealth in nvim if anything looks off.
  * Make sure ~/.local/bin is on your PATH (for `fd`).
EOF
}

main "$@"
