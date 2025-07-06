# Nix Configurations

My personal NixOS system and Home Manager configurations for a complete desktop environment setup.

## 📋 Overview

This repository contains my complete Nix-based system configuration, including:

- **NixOS System Configuration**: Core system settings, hardware configuration, and services
- **Home Manager Configuration**: User-space applications and desktop environment
- **Development Shells**: Reproducible development environments for various programming languages
- **Desktop Environment**: Complete Hyprland-based Wayland desktop with custom theming

## 🏗️ Repository Structure

```
nix-configs/
├── copy-nix-configs.sh          # Script to sync configurations from system
├── nixos/                       # NixOS system configuration
│   ├── configuration.nix        # Main system configuration
│   ├── hardware-configuration.nix
│   ├── desktop-configuration.nix
│   ├── nvidia-configuration.nix
│   ├── packages.nix
│   └── services.nix
├── home-manager/             # Home Manager user configuration
│   ├── home.nix              # Main home configuration entry point
│   ├── packages.nix          # User packages
│   ├── git.nix               # Git configuration
│   ├── zsh.nix               # Zsh shell configuration
│   ├── kitty.nix             # Terminal emulator
│   ├── neovim.nix            # Neovim editor
│   ├── yazi.nix              # File manager
│   ├── btop.nix              # System monitor
│   ├── fastfetch.nix         # System info tool
│   ├── xdg.nix               # XDG directories
│   ├── config-resources/     # Static config files and assets
│   └── desktop/              # Desktop environment configuration
│       ├── hyprland.nix      # Hyprland window manager
│       ├── waybar.nix        # Status bar
│       ├── rofi.nix          # Application launcher
│       ├── dunst.nix         # Notification daemon
│       ├── hyprlock.nix      # Screen locker
│       ├── hyprpaper.nix     # Wallpaper manager
│       ├── wlogout.nix       # Logout menu
│       ├── gtk.nix           # GTK theming
│       └── binds.nix         # Keybindings
└── nix-shells/               # Development environments
    ├── <enviroments>.nix
    └── lib/                  # Shared library functions
```

## 🖥️ Desktop Environment

### Key Components

- **Window Manager**: Hyprland with custom configuration
- **Terminal**: Kitty with custom theming
- **Shell**: Zsh with custom configuration
- **Editor**: VS Code and Neovim with plugins
- **File Manager**: Thunar and Yazi with custom theme
- **Status Bar**: Waybar with system information
- **Launcher**: Rofi as application and command launcher
- **Notifications**: Dunst notification daemon
- **Screen Lock**: Hyprlock with custom styling
- **Logout Menu**: Wlogout with custom icons

### System Monitor & Tools

- **btop**: Modern system monitor
- **fastfetch**: System information display
- **Git**: Version control with custom configuration

## 🛠️ Development Environments

For details about available development shells, explore the `nix-shells/` directory.

## 🎨 Theming & Assets

Custom assets and themes included:
- Desktop wallpapers
- User avatar
- Rofi background
- Wlogout icons (lock, logout, reboot, shutdown)
- Yazi file manager theme
- Fastfetch custom logo

## 🔧 Configuration Highlights

### Hardware Support
- **NVIDIA GPU** configuration with proper drivers
- **Network Manager** for connectivity
- **Audio** with PipeWire
- **Bluetooth** support

### Security & Authentication
- **Polkit** for privilege escalation
- **GNOME Keyring** for credential management

## 📝 Customization

### Adding New Packages

1. **System packages**: Add to `nixos/packages.nix`
2. **User packages**: Add to `home-manager/packages.nix`
3. **Development tools**: Create new shell in `nix-shells/`

### Modifying Desktop Environment

- **Window manager**: Edit `home-manager/desktop/hyprland.nix`
- **Status bar**: Customize `home-manager/desktop/waybar.nix`
- **Keybindings**: Update `home-manager/desktop/binds.nix`
- **Theming**: Modify `home-manager/desktop/gtk.nix`
