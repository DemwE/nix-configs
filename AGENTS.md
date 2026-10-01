# NixOS Configuration — Agent Guide

## Repo structure
- `flake.nix` — inputs, outputs (nixosConfigurations, homeConfigurations, devShells, apps), overlays
- `flake.lock` — locked inputs (nie edytować ręcznie, używaj update-lock)
- `configuration.nix` — główny entry point (importuje users, groups, paths, base config)
- `modules/` — git submodule → `github:DemwE/nix-modules` (custom options, feature modules)
- `users/` — definicje użytkowników (`demwe.nix`, `admin.nix`)
- `hosts/` — per-host config (`NixBook/`, `DemwEPC/`, `N1/`), hardware configs (`hardware-configuration.nix`)
- `home/` — Home Manager config dla `demwe` (homeConfigurations zintegrowane przez flake)
- `resources/` — statyczne zasoby (avatary, tapety, theme)

## Kluczowe konwencje
- Custom options pod namespacem `my.*` (np. `my.features.nvidia.enable`)
- Feature flagi przez `mkEnableOption` + `mkIf` (moduły w `modules/`)
- Overlay `pkgs.unstable` dostępny w każdym kontekście (dodatkowe overlays wg potrzeb w flake)
- `self.submodules = true` — moduły trzymane jako submodule, Nix widzi przez flake
- `audio.quality`: domyślnie `"normal"`, host może ustawić `my.audio.quality = "high"`

## Hosts
- **NixBook** (laptop): Intel (iGPU) + NVIDIA (dGPU, Prime/Optimus/offload), BTRFS + preservation/impermanence
- **DemwEPC** (desktop): AMD (CPU) + NVIDIA (discrete GPU), ext4
- **N1** (server): Intel, mdadm RAID, NFS exports, fancontrol

## Workflow
- `switch <host>` — `nix run .#switch <host>` (flake app, wrapper `nh os switch`)
- `boot <host>` — `nix run .#boot <host>` (flake app, wrapper `nh os boot`)
- `update-lock` — `nix run .#update-lock` (flake app, `nh flake update`)
- `update` — `nix run .#update` (flake app)
- `remote-switch` — build/deploy przez SSH (remote switch via nh)
- `vm <host>` — `nix run .#vm <host>` (test VM dla hosta)
- `test` — `nix run .#test` (szybkie checki)
- `clean` — `nix run .#clean` (czyszczenie)
- `gc` — `nix run .#gc` (garbage collection)

## Dev shell / tooling
- Wejście do dev shell: `nix develop` (lub `nix develop .#default`)
- Zawiera: pre-commit, nixpkgs-fmt, statix, deadnix, nh, nixvim i inne narzędzia przydatne przy pracy z configiem

## Ważne
- Przed edycją w `modules/` sprawdź stan submodule: `git submodule status`. Upewnij się, że jest na właściwym commicie/branchu.
- Po zmianie w `modules/`: commit + push zmian w samym submodule (`modules/`), następnie zaktualizuj pointer w głównym repo (`git add modules && git commit -m "modules: update submodule"`).
- Przy świeżym klonie: `git submodule update --init --recursive`.
- Nigdy nie commituj sekretów/kluczy.
- Po istotnych zmianach warto sprawdzić poprawność: `nix flake check`, ewaluacja/build hosta przed switch (nh/build).