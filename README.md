# NixOS Configuration

Modular NixOS configuration with flakes.

## Quick Start

```bash
# Update system
update

# Update package versions
update-lock

# Check config
update-check
```

## Structure

```
nix-configs/
├── flake.nix              # Flake inputs & outputs (version, channels)
├── configuration.nix      # Main entry point (imports modules/)
│
├── modules/               # All NixOS modules
│   ├── default.nix        # Global imports (common, users, system, features, hosts)
│   │
│   ├── common/            # Shared modules for all hosts
│   │   ├── boot/          # Boot config (kernel selection)
│   │   ├── networking/    # Network config (hostname, VPN)
│   │   ├── services/      # System services (ssh, printing, firewall)
│   │   └── packages/      # System packages
│   │
│   ├── features/         # Feature modules (nvidia, steam, docker, etc.)
│   │
│   ├── overlays/         # Package overlays (custom, stable)
│   │
│   ├── users/            # User configuration
│   │   └── demwe/
│   │       ├── packages/  # User packages by category
│   │       │   ├── browsers.nix
│   │       │   ├── development.nix
│   │       │   ├── games.nix
│   │       │   └── ...
│   │       └── default.nix
│   │
│   ├── hosts/            # Host-specific configs
│   │   └── NixBook/
│   │       ├── boot.nix         # Kernel: unstable
│   │       ├── networking.nix   # Hostname: NixBook
│   │       ├── features.nix      # Services & features
│   │       └── hardware-configuration.nix
│   │
│   └── system/           # System modules (fonts, audio, etc.)
│
└── home/demwe/          # Home Manager config
    ├── zsh.nix           # Shell aliases & config
    ├── neovim.nix
    └── ...
```

## Version

System version is defined in `flake.nix` (line 21: `systemVersion = "25.11"`).

To upgrade: change version in flake.nix, then run `update-lock`.

## Package Channels

Packages can be mixed from different channels in a single list:

```nix
with pkgs; [
  firefox              # stable (nixos-25.11)
  blender              # stable
  unstable.obs-studio  # nixos-unstable
  custom.rust-rover   # custom packages (modules/directives/)
]
```

- No prefix → stable (nixos-25.11)
- `unstable.xxx` → nixos-unstable
- `custom.xxx` → custom packages (in modules/directives/)
- `stable.xxx` → explicit stable (same as default)

## Adding New Packages

### Nix packages (system)
Add to appropriate file in `modules/users/demwe/packages/`:
- `browsers.nix`
- `development.nix`
- `games.nix`
- `creativity.nix` (graphics, video)
- `office.nix`
- etc.

### Flatpak packages
Edit `modules/users/demwe/packages/flatpak.nix`:
```nix
services.flatpak.packages = [
  "com.discordapp.Discord"
];
```

### Custom packages (from modules/directives)
Add package definition in `modules/directives/`, then use as `custom.<name>`.

## Adding a New Host

1. Create `modules/hosts/<hostname>/`
2. Add files: `boot.nix`, `networking.nix`, `features.nix`, `hardware-configuration.nix`
3. Import in `modules/default.nix`: `./hosts/<hostname>`

## Files

- `configuration.nix` - Main entry point
- `flake.nix` - Flake configuration (inputs, outputs)
- `flake.lock` - Locked versions (don't edit manually)