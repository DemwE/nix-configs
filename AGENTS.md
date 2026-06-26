# NixOS Configuration — Agent Guide

## Repo structure
- `flake.nix` — inputs, hosts, overlays, devShell
- `configuration.nix` — główny entry point (importuje users, groups, paths)
- `modules/` — git submodule → `github:DemwE/nix-modules`
- `users/` — definicje użytkowników (demwe, admin)
- `hosts/` — per-host config (NixBook, DemwEPC, N1)
- `home/` — Home Manager config dla demwe
- `resources/` — statyczne zasoby (avatary, tapety, theme)

## Kluczowe konwencje
- Custom options pod namespacem `my.*` (np. `my.features.nvidia.enable`)
- Feature flagi przez `mkEnableOption` + `mkIf`
- Overlay `pkgs.unstable` dostępny w każdym kontekście
- `self.submodules = true` — moduły w submodule, Nix widzi przez flake

## Hosts
- **NixBook** (laptop): Intel + NVIDIA Prime, BTRFS + preservation
- **DemwEPC** (desktop): AMD + NVIDIA, ext4
- **N1** (server): Intel, RAID, NFS, fancontrol

## Workflow
- `switch <host>` — `nh os switch` przez skrypt
- `switch-check <host>` — such-run
- `update-lock` — `nix flake lock`
- `remote-switch` — build przez SSH

## Ważne
- Przed edycją w `modules/` sprawdź czy submodule jest na właściwym commicie
- Po zmianie w `modules/` → commit + push w submodule, potem update pointera w głównym repo
- `audio.quality`: domyślnie `"normal"`, host może ustawić `my.audio.quality = "high"`
