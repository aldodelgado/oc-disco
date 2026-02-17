#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE="https://raw.githubusercontent.com/aldodelgado/oc-disco/main"
APP_NAME="oc-disco"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/${APP_NAME}"
BIN_DIR="${HOME}/.local/bin"
ZSH_ALIASES="${CONFIG_DIR}/aliases.zsh"
BASH_ALIASES="${CONFIG_DIR}/aliases.bash"

ZSHRC="${HOME}/.zshrc"
BASHRC="${HOME}/.bashrc"

MARKER_BEGIN="# >>> ${APP_NAME} aliases (managed) >>>"
MARKER_END="# <<< ${APP_NAME} aliases (managed) <<<"

need_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1" >&2; exit 1; }; }

fetch() {
  # fetch <url> <dest>
  local url="$1" dest="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  else
    wget -qO "$dest" "$url"
  fi
}

ensure_dirs() {
  mkdir -p "$CONFIG_DIR" "$BIN_DIR"
}

ensure_loader_block() {
  # ensure_loader_block <rcfile> <shell> <path_to_aliases>
  local rcfile="$1" shell="$2" aliases_path="$3"

  touch "$rcfile"

  # Remove old block if present (idempotent)
  if grep -Fq "$MARKER_BEGIN" "$rcfile"; then
    # delete between markers
    awk -v b="$MARKER_BEGIN" -v e="$MARKER_END" '
      $0==b {inblock=1; next}
      $0==e {inblock=0; next}
      !inblock {print}
    ' "$rcfile" > "${rcfile}.tmp"
    mv "${rcfile}.tmp" "$rcfile"
  fi

  cat >> "$rcfile" <<EOF

${MARKER_BEGIN}
# Source ${APP_NAME} managed aliases (auto-updated file)
if [ -f "${aliases_path}" ]; then
  . "${aliases_path}"
fi
${MARKER_END}
EOF

  echo "Updated loader block in ${rcfile} (${shell})."
}

install_shim() {
  local shim="${BIN_DIR}/${APP_NAME}"
  cat > "$shim" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

APP_NAME="oc-disco"
REPO_RAW_BASE="https://raw.githubusercontent.com/aldodelgado/oc-disco/main"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/${APP_NAME}"
ZSH_ALIASES="${CONFIG_DIR}/aliases.zsh"
BASH_ALIASES="${CONFIG_DIR}/aliases.bash"

fetch() {
  local url="$1" dest="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  else
    wget -qO "$dest" "$url"
  fi
}

cmd="${1:-help}"
case "$cmd" in
  update)
    mkdir -p "$CONFIG_DIR"
    fetch "${REPO_RAW_BASE}/aliases/aliases.zsh" "$ZSH_ALIASES.tmp"
    fetch "${REPO_RAW_BASE}/aliases/aliases.bash" "$BASH_ALIASES.tmp"
    mv "$ZSH_ALIASES.tmp" "$ZSH_ALIASES"
    mv "$BASH_ALIASES.tmp" "$BASH_ALIASES"
    echo "${APP_NAME}: aliases updated."
    echo "Restart your shell or run: source ~/.zshrc (zsh) or source ~/.bashrc (bash)"
    ;;
  help|*)
    cat <<H
${APP_NAME} commands:
  ${APP_NAME} update   Pull latest aliases from GitHub into ~/.config/${APP_NAME}/
H
    ;;
esac
EOF
  chmod +x "$shim"
  echo "Installed command shim: $shim"
  echo "Make sure ~/.local/bin is on your PATH."
}

main() {
  need_cmd awk
  if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
    echo "Need curl or wget installed." >&2
    exit 1
  fi

  ensure_dirs

  # initial download (atomic write)
  fetch "${REPO_RAW_BASE}/aliases/aliases.zsh" "${ZSH_ALIASES}.tmp"
  fetch "${REPO_RAW_BASE}/aliases/aliases.bash" "${BASH_ALIASES}.tmp"
  mv "${ZSH_ALIASES}.tmp" "$ZSH_ALIASES"
  mv "${BASH_ALIASES}.tmp" "$BASH_ALIASES"

  # loader blocks
  ensure_loader_block "$ZSHRC" "zsh" "$ZSH_ALIASES"
  ensure_loader_block "$BASHRC" "bash" "$BASH_ALIASES"

  install_shim

  cat <<EOF

Done ✅
Next steps:
  1) Restart your terminal (or run: source ~/.zshrc or source ~/.bashrc)
  2) Anytime you want updates: ${APP_NAME} update

EOF
}

main "$@"
