# NixOS Configuration

Modular NixOS configuration with flakes.

## Quick Start

```bash
# Update flake lock
update-lock

# Check host configuration (requires hostname argument)
switch-check NixBook
switch-check DemwEPC

# Switch to specific host (requires hostname argument)
switch NixBook
switch DemwEPC
```

## Structure

```
nix-configs/
├── flake.nix              # Flake inputs & outputs (version, channels)
├── configuration.nix      # Main entry point (imports modules/)
│
├── modules/               # All NixOS modules
│   ├── default.nix        # Global imports (common, users, system, features)
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
│   ├── directives/       # Custom packages & tools
│   │   └── utils/        # Custom utilities (switch, compress, battery, gpu)
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
│   └── system/           # System modules (fonts, audio, etc.)
│
├── hosts/                # Host-specific configs
│   └── <hosts>
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

1. Create `hosts/<hostname>/` (in project root)
2. Add files: `boot.nix`, `networking.nix`, `features.nix`, `hardware-configuration.nix`
3. Add host to `flake.nix`:
  ```nix
  nixosConfigurations.Hostname = nixpkgs.lib.nixosSystem { ... };
  ```

## Building Different Hosts

```bash
# Using custom switch command (requires argument)
switch NixBook
switch DemwEPC

# Using nixos-rebuild directly
sudo nixos-rebuild switch --flake .#NixBook --log-format bar-with-logs
sudo nixos-rebuild switch --flake .#DemwEPC --log-format bar-with-logs
```

## Files

- `configuration.nix` - Main entry point
- `flake.nix` - Flake configuration (inputs, outputs)
- `flake.lock` - Locked versions (don't edit manually)