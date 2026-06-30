#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${PETROVICH_INSTALL_DIR:-$HOME/.local/share/petrovich-meme}"
BIN_DIR="${PETROVICH_BIN_DIR:-$HOME/.local/bin}"
BIN_NAME="petrovich-meme"
REPO="https://github.com/user/petrovich-meme-linux.git"

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { echo -e "${GREEN}→${NC} $*"; }
warn()  { echo -e "${RED}→${NC} $*"; }
step()  { echo -e "${CYAN}==>${NC} $*"; }

# ---- detect package manager ----
step "Detecting package manager..."

install_deps() {
    if command -v apt &>/dev/null; then
        info "apt detected"
        sudo apt update -qq
        sudo apt install -y feh xclip xdotool
    elif command -v dnf &>/dev/null; then
        info "dnf detected"
        sudo dnf install -y feh xclip xdotool
    elif command -v pacman &>/dev/null; then
        info "pacman detected"
        sudo pacman -S --noconfirm feh xclip xdotool
    elif command -v zypper &>/dev/null; then
        info "zypper detected"
        sudo zypper install -y feh xclip xdotool
    elif command -v nix-shell &>/dev/null; then
        info "nix detected — skipping deps, use nix develop from the repo"
        return
    else
        warn "Unknown package manager. Install manually: feh xclip xdotool"
        return
    fi
    info "Dependencies installed"
}

# ---- install / update ----
step "Installing petrovich-meme to $INSTALL_DIR..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_SCRIPT="$SCRIPT_DIR/petrovich-meme"

if [[ -f "$LOCAL_SCRIPT" ]]; then
    # running from repo — copy locally
    mkdir -p "$INSTALL_DIR"
    cp "$LOCAL_SCRIPT" "$INSTALL_DIR/petrovich-meme"
    if [[ -d "$SCRIPT_DIR/stickers" ]]; then
        cp -r "$SCRIPT_DIR/stickers" "$INSTALL_DIR/stickers" 2>/dev/null || true
    fi
    info "Installed from local repo"
elif [[ -d "$INSTALL_DIR/.git" ]]; then
    info "Already installed, pulling updates..."
    git -C "$INSTALL_DIR" pull --ff-only
else
    if [[ -d "$INSTALL_DIR" ]]; then
        warn "$INSTALL_DIR exists — backing up..."
        mv "$INSTALL_DIR" "${INSTALL_DIR}.bak.$(date +%s)"
    fi
    git clone --depth 1 "$REPO" "$INSTALL_DIR"
    info "Cloned from $REPO"
fi

# ---- symlink ----
step "Creating command..."

mkdir -p "$BIN_DIR"
ln -sf "$INSTALL_DIR/petrovich-meme" "$BIN_DIR/$BIN_NAME"
info "$BIN_NAME → $BIN_DIR/$BIN_NAME"

# ---- PATH check ----
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    warn ""
    warn "Add $BIN_DIR to your PATH:"
    echo ""
    echo "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
    echo "  source ~/.bashrc"
    echo ""
fi

echo ""
step "Done! Run: $BIN_NAME"
