#!/bin/bash
# ╭─────────────────────────────────────────╮
# │           kosame — install.sh           │
# │   Parrot OS Lofi Rice by seto           │
# ╰─────────────────────────────────────────╯

set -e
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo -e "${CYAN}→ $1${NC}"; }
ok()   { echo -e "${GREEN}✓ $1${NC}"; }
warn() { echo -e "${YELLOW}! $1${NC}"; }

echo ""
echo "╭─────────────────────────────────────╮"
echo "│       kosame dotfiles installer     │"
echo "│       Parrot OS • KDE Plasma        │"
echo "╰─────────────────────────────────────╯"
echo ""

# Dependencies
step "Installing dependencies..."
sudo apt update -q
sudo apt install -y \
    zsh git curl wget unzip \
    conky-all cbonsai cmatrix \
    papirus-icon-theme \
    qt5-style-kvantum \
    btop pipx \
    locale-gen 2>/dev/null || true
ok "Dependencies installed"

# Locale
step "Setting up English locale..."
sudo locale-gen en_US.UTF-8 > /dev/null 2>&1 || true
ok "Locale configured"

# Fastfetch
step "Installing fastfetch..."
if ! command -v fastfetch &>/dev/null; then
    wget -q "https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb" \
        -O /tmp/fastfetch.deb && sudo dpkg -i /tmp/fastfetch.deb > /dev/null 2>&1 || warn "Fastfetch install failed"
fi
ok "Fastfetch ready"

# JetBrains Mono Nerd Font
step "Installing JetBrains Mono Nerd Font..."
mkdir -p ~/.local/share/fonts/JetBrainsMono
wget -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" \
    -O /tmp/JBMono.zip 2>/dev/null && \
    unzip -q -o /tmp/JBMono.zip -d ~/.local/share/fonts/JetBrainsMono/ && \
    fc-cache -fv > /dev/null 2>&1 && ok "Font installed" || warn "Font install skipped"

# Oh My Zsh
step "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
fi
ok "Oh My Zsh ready"

# Zsh plugins
step "Installing Zsh plugins..."
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true
ok "Plugins installed"

# Starship
step "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null 2>&1 && ok "Starship installed" || warn "Starship install failed"

# KDE Material You Colors
step "Installing kde-material-you-colors..."
pipx install kde-material-you-colors --system-site-packages > /dev/null 2>&1 && \
    ok "kde-material-you-colors installed" || warn "Already installed or failed"

# Cava
step "Installing cava..."
if ! command -v cava &>/dev/null; then
    sudo apt install -y libfftw3-dev libasound2-dev libncursesw5-dev libpulse-dev autoconf automake > /dev/null 2>&1
    git clone --quiet https://github.com/karlstav/cava.git /tmp/cava 2>/dev/null
    cd /tmp/cava && ./autogen.sh > /dev/null 2>&1 && ./configure > /dev/null 2>&1 && \
        make -j$(nproc) > /dev/null 2>&1 && sudo make install > /dev/null 2>&1 && ok "Cava installed" || warn "Cava install failed"
    cd "$DOTFILES"
else
    ok "Cava already installed"
fi

# Copy configs
step "Installing configs..."
cp -r "$DOTFILES/.config/cava"      ~/.config/
cp -r "$DOTFILES/.config/conky"     ~/.config/
cp -r "$DOTFILES/.config/fastfetch" ~/.config/
cp -r "$DOTFILES/.config/btop"      ~/.config/
cp -r "$DOTFILES/.config/gtk-3.0"   ~/.config/
cp -r "$DOTFILES/.config/autostart" ~/.config/
cp -r "$DOTFILES/.config/konsole"   ~/.config/
cp    "$DOTFILES/.config/starship.toml" ~/.config/
cp    "$DOTFILES/home/.zshrc"       ~/
cp    "$DOTFILES/home/.gtkrc-2.0"   ~/
ok "Configs installed"

# KDE settings
step "Applying KDE settings..."
kwriteconfig5 --file kdeglobals --group Icons --key Theme Papirus-Dark 2>/dev/null || true
kwriteconfig5 --file kdeglobals --group KDE --key widgetStyle kvantum-dark 2>/dev/null || true
kwriteconfig5 --file kdeglobals --group General --key ColorScheme MaterialYouDark 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key wobblyWindowsEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key magiclampEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Effect-blur --key BlurStrength 4 2>/dev/null || true
ok "KDE settings applied"

# Wallpaper
step "Downloading wallpaper..."
mkdir -p ~/Pictures/Wallpapers
wget -q "https://raw.githubusercontent.com/Hydradevx/Wallpaper-Bank/main/Pastel-Window.png" \
    -O ~/Pictures/Wallpapers/kosame-wall.png 2>/dev/null && \
    plasma-apply-wallpaperimage ~/Pictures/Wallpapers/kosame-wall.png 2>/dev/null && \
    ok "Wallpaper set" || warn "Wallpaper download failed — set manually"

# Set Zsh as default
step "Setting Zsh as default shell..."
chsh -s $(which zsh) 2>/dev/null && ok "Zsh set as default" || warn "Run: chsh -s $(which zsh)"

echo ""
echo "╭──────────────────────────────────────╮"
echo "│  ✓ kosame installation complete!     │"
echo "│                                      │"
echo "│  Next steps:                         │"
echo "│  1. Log out and log back in          │"
echo "│  2. Run: kde-material-you-colors     │"
echo "│  3. Enjoy your rice! 🌧️              │"
echo "╰──────────────────────────────────────╯"
