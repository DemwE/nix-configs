# NixOS Configuration

Modular NixOS and Home Manager configuration managed with flakes.

## Quick Start

```bash
# Update the flake lock
update-lock

# Check a host before switching
switch-check NixBook
switch-check DemwEPC

# Switch to a host
switch NixBook
switch DemwEPC

# Switch a host through a remote build machine
remote-switch NixBook user@build-host
```

## Repository Layout

```text
nix-configs/
├── flake.nix
├── configuration.nix
├── hosts/
│   ├── NixBook/
│   └── DemwEPC/
├── modules/
│   ├── default.nix
│   ├── common/
│   ├── directives/
│   ├── features/
│   ├── overlays/
│   ├── system/
│   ├── users/
│   └── paths.nix
├── home/
│   └── demwe/
└── resources/
```

`modules/default.nix` wires together the shared system layers. The actual user account glue lives in `modules/users/demwe/`, while the Home Manager module set is under `home/demwe/` and gets imported from there.

## Host Setup

The repository currently defines two NixOS hosts in `flake.nix`:

1. `NixBook`
2. `DemwEPC`

Each host has its own directory under `hosts/<hostname>/` with the local boot, networking, features, and hardware configuration split out there.

## Home Manager Layout

The `home/demwe/` directory contains the per-user Home Manager modules, split by concern:

`home/demwe/home.nix` imports the rest of the user modules such as `zsh.nix`, `neovim.nix`, `git.nix`, `packages.nix`, and the various toolchain files.

## Custom Commands And Packages

Helper commands are packaged under `modules/directives/utils/` and exposed as system packages. The most visible ones are `switch`, `switch-check`, `update-lock`, `remote-switch`, `cls`, `compress`, and `decompress`.

Custom package definitions and overlays live in `modules/directives/`, `modules/overlays/`, and `modules/features/`. Use the `custom.<name>` namespace when a package is defined there.

## Versioning

This repo is pinned to NixOS 25.11 in `flake.nix`.

To upgrade, change the pinned channel in `flake.nix` and run `update-lock`.

## Package Channels

Packages can be mixed from different channels in one list:

```nix
with pkgs; [
  firefox
  blender
  unstable.obs-studio
  custom.rust-rover
]
```

Rules of thumb:

- No prefix means the pinned stable channel.
- `unstable.<name>` comes from `nixpkgs-unstable`.
- `custom.<name>` comes from `modules/directives/`.
- `stable.<name>` is the explicit stable channel alias.

## Adding Something New

To add a new package for the system or the user, put it in the relevant module file under `modules/common/packages/` or `home/demwe/`.

To add a new host, create a directory under `hosts/`, add it to `flake.nix`, and keep the host-specific boot, networking, and feature settings there.

## Useful Files

- `configuration.nix` - Main NixOS entry point
- `flake.nix` - Flake inputs and outputs
- `flake.lock` - Locked dependency versions
