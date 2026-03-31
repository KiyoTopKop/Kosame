<div align="center">

# 🌧️ seto's dotfiles

### Parrot OS • KDE Plasma • Lofi Caelestia-inspired Rice

![Parrot OS](https://img.shields.io/badge/Parrot_OS-7.1-1de9b6?style=for-the-badge&logo=linux&logoColor=white)
![KDE Plasma](https://img.shields.io/badge/KDE_Plasma-6.3-1d99f3?style=for-the-badge&logo=kde&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-f09785?style=for-the-badge)

</div>

---

## 🎨 Color Palette

| Name | Hex | Preview |
|------|-----|---------|
| Background | `#0a0f10` | ![#0a0f10](https://via.placeholder.com/15/0a0f10/000000?text=+) |
| Foreground | `#c8e1e8` | ![#c8e1e8](https://via.placeholder.com/15/c8e1e8/000000?text=+) |
| Red/Salmon | `#f09785` | ![#f09785](https://via.placeholder.com/15/f09785/000000?text=+) |
| Yellow/Warm | `#ecb69b` | ![#ecb69b](https://via.placeholder.com/15/ecb69b/000000?text=+) |
| Blue | `#c9d7fa` | ![#c9d7fa](https://via.placeholder.com/15/c9d7fa/000000?text=+) |
| Cyan | `#bedfed` | ![#bedfed](https://via.placeholder.com/15/bedfed/000000?text=+) |
| White | `#e0f3f4` | ![#e0f3f4](https://via.placeholder.com/15/e0f3f4/000000?text=+) |
| Teal | `#9ab1b8` | ![#9ab1b8](https://via.placeholder.com/15/9ab1b8/000000?text=+) |

> Colors are dynamically generated from wallpaper using **kde-material-you-colors**

---

## 🛠️ Setup

### Dependencies

| Package | Purpose |
|---------|---------|
| `kde-material-you-colors` | Dynamic wallpaper-based theming |
| `papirus-icon-theme` | Icons |
| `qt5-style-kvantum` | Qt app transparency |
| `conky-all` | Desktop system monitor |
| `cava` | Music visualizer |
| `cbonsai` | Bonsai tree screensaver |
| `cmatrix` | Matrix rain |
| `fastfetch` | System info on terminal open |
| `btop` | System monitor |
| `zsh` + `oh-my-zsh` | Shell |
| `starship` | Shell prompt |
| `JetBrainsMono NF` | Font |

### Quick Install

```bash
git clone https://github.com/KiyoTopKop/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

---

## 📁 File Structure

```
dotfiles/
├── .config/
│   ├── cava/          # Music visualizer config
│   ├── conky/         # Desktop clock & stats
│   ├── fastfetch/     # Terminal fetch config + ASCII art
│   │   └── arts/      # ASCII art files
│   ├── btop/          # System monitor + theme
│   │   └── themes/    # Custom lofi theme
│   ├── starship.toml  # Shell prompt config
│   ├── gtk-3.0/       # GTK theme settings
│   └── autostart/     # Autostart services
├── home/
│   ├── .zshrc         # Zsh config
│   └── .gtkrc-2.0     # GTK2 settings
├── wallpapers/        # Wallpapers (add yours here)
├── screenshots/       # Desktop screenshots
├── install.sh         # Automated install script
└── README.md          # This file
```

---

## ⚙️ KDE Settings Applied

### Appearance
- **Icons**: Papirus-Dark
- **Application Style**: Kvantum-dark
- **Window Decorations**: Sweet-Mars
- **Color Scheme**: MaterialYouDark (dynamic)

### Effects
- ✅ Blur (strength: 4)
- ✅ Wobbly Windows
- ✅ Magic Lamp (minimize)
- ✅ Fade

### Terminal (Konsole)
- **Color Scheme**: MaterialYou
- **Font**: JetBrainsMono NF 11pt
- **Background**: Transparent + slight blur
- **Opacity**: 85%

---

## 🖥️ Terminal Tools

```bash
cbonsai -l        # Animated bonsai tree
cmatrix -C cyan   # Matrix rain
cava              # Music visualizer
btop              # System monitor
fastfetch         # System info
pipes.sh          # Animated pipes
```

---

## 🔑 Key Shortcuts

| Shortcut | Action |
|----------|--------|
| `Meta + Left/Right` | Snap window to half |
| `Meta + Up/Down` | Maximize / minimize |
| `Meta + T` | Open terminal |
| `Meta + R` | Run command (KRunner) |
| `Print Screen` | Screenshot |

---

## 📦 Additional Tools

### SDDM Login Screen
The SDDM login screen uses the Debian theme with a custom wallpaper.
Place your wallpaper at:
```
/usr/share/desktop-base/active-theme/login/background-nologo.jpg
```

### Firefox
- Extension: **Tabliss** (new tab page with wallpaper)
- Custom CSS in `~/.mozilla/firefox/*/chrome/userChrome.css`

---

## 🎵 Music Setup

For the music visualizer (cava) to work with audio:
```bash
# PulseAudio
echo "[input]
method = pulse" >> ~/.config/cava/config
```

---

## 📜 License

MIT License — feel free to use and modify!

---

<div align="center">
Made with 🌧️ on Parrot OS
</div>
