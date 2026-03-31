#!/bin/bash
# ╭──────────────────────────────────────╮
# │   Seto's Parrot OS Rice Install      │
# │   Lofi Caelestia-inspired Setup      │
# ╰──────────────────────────────────────╯

set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"

echo "╭─────────────────────────────────╮"
echo "│  Installing Seto's Dotfiles...  │"
echo "╰─────────────────────────────────╯"

# 1. Install dependencies
echo "→ Installing dependencies..."
sudo apt update -q
sudo apt install -y \
    zsh git curl wget unzip \
    conky-all cava cbonsai cmatrix \
    papirus-icon-theme \
    qt5-style-kvantum \
    fastfetch \
    btop \
    pipx \
    fonts-font-awesome 2>/dev/null || true

# 2. Install JetBrains Mono Nerd Font
echo "→ Installing JetBrains Mono Nerd Font..."
mkdir -p ~/.local/share/fonts/JetBrainsMono
wget -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" \
    -O /tmp/JBMono.zip 2>/dev/null && \
    unzip -q /tmp/JBMono.zip -d ~/.local/share/fonts/JetBrainsMono/ && \
    fc-cache -fv > /dev/null 2>&1 || echo "Font install skipped"

# 3. Install Oh My Zsh
echo "→ Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Install Zsh plugins
echo "→ Installing Zsh plugins..."
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true

# 5. Install Starship
echo "→ Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null 2>&1 || true

# 6. Install kde-material-you-colors
echo "→ Installing KDE Material You Colors..."
pipx install kde-material-you-colors --system-site-packages 2>/dev/null || true

# 7. Copy configs
echo "→ Copying config files..."
cp -r "$DOTFILES_DIR/.config/cava" ~/.config/
cp -r "$DOTFILES_DIR/.config/conky" ~/.config/
cp -r "$DOTFILES_DIR/.config/fastfetch" ~/.config/
cp -r "$DOTFILES_DIR/.config/btop" ~/.config/
cp -r "$DOTFILES_DIR/.config/gtk-3.0" ~/.config/
cp "$DOTFILES_DIR/.config/starship.toml" ~/.config/
cp -r "$DOTFILES_DIR/.config/autostart" ~/.config/
cp "$DOTFILES_DIR/home/.zshrc" ~/
cp "$DOTFILES_DIR/home/.gtkrc-2.0" ~/

# 8. Set Zsh as default shell
echo "→ Setting Zsh as default shell..."
chsh -s $(which zsh) 2>/dev/null || true

# 9. Apply KDE settings
echo "→ Applying KDE settings..."
kwriteconfig5 --file kdeglobals --group Icons --key Theme Papirus-Dark 2>/dev/null || true
kwriteconfig5 --file kdeglobals --group KDE --key widgetStyle kvantum-dark 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key wobblyWindowsEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Plugins --key magiclampEnabled true 2>/dev/null || true
kwriteconfig5 --file kwinrc --group Effect-blur --key BlurStrength 4 2>/dev/null || true

echo ""
echo "╭─────────────────────────────────╮"
echo "│  ✓ Installation Complete!       │"
echo "│  Please log out and log back in │"
echo "│  to apply all changes.          │"
echo "╰─────────────────────────────────╯"
