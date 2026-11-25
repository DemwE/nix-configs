# NixOS Configuration — Agent Guide

## Repo structure
- `flake.nix` — inputs, outputs (`nixosConfigurations`, `devShells`), overlay `pkgs.unstable`
- `flake.lock` — locked inputs (nie edytować ręcznie, używaj `update-lock`)
- `configuration.nix` — główny entry point (importuje `modules`, `users`, `groups.nix`, `paths.nix`)
- `modules/` — git submodule → `github:DemwE/nix-modules` (custom options, feature modules, directives, overlays)
- `users/` — definicje użytkowników (`demwe/`, `admin/`) oraz wspólna konfiguracja Home Manager (`default.nix`)
- `hosts/` — per-host config (`NixBook/`, `DemwEPC/`, `N1/`), hardware configs (`hardware-configuration.nix`)
- `home/` — konfiguracje Home Manager dla `demwe/` i `admin/` (zintegrowane jako moduł NixOS)
- `resources/` — statyczne zasoby (avatary, tapety, motywy, szablony)

## Kluczowe konwencje
- Custom options pod namespacem `my.*` (np. `my.features.nvidia.enable`)
- Feature flagi przez `mkEnableOption` + `mkIf` (moduły w `modules/`)
- Overlay `pkgs.unstable` oraz `pkgs.custom` dostępne w każdym kontekście
- `self.submodules = true` — moduły trzymane jako submodule, Nix widzi przez flake
- `audio.quality`: domyślnie `"normal"`, host może ustawić `my.audio.quality = "high"`

## Hosts
- **NixBook** (laptop): Intel (iGPU) + NVIDIA (dGPU, Prime/Optimus/offload), BTRFS + preservation/impermanence
- **DemwEPC** (desktop): AMD (CPU) + NVIDIA (discrete GPU), ext4
- **N1** (server): Intel, mdadm RAID, NFS exports, fancontrol

## Workflow
Narzędzia systemowe z `modules/directives/utils/` (dostępne w `$PATH` jako pakiety `custom.*`):
- `switch <host>` — `nh os switch /home/nixos-configs --hostname <host>`
- `boot <host>` — `nh os boot /home/nixos-configs --hostname <host>`
- `remote-switch <host> <user@build-host>` — zdalny build i switch przez `nh`
- `update-lock` — aktualizacja `flake.lock` (`nix flake update --flake /home/nixos-configs`)
- `nh clean all` — ręczne czyszczenie generacji (automatyczne GC działa przez `programs.nh.clean`)

## Dev shell / tooling
- Wejście do dev shell: `nix develop` (lub `nix develop .#default`)
- Zawiera: `nixfmt`

## Ważne
- Przed edycją w `modules/` sprawdź stan submodule: `git submodule status`. Upewnij się, że jest na właściwym commicie/branchu.
- Po zmianie w `modules/`: commit + push zmian w samym submodule (`modules/`), następnie zaktualizuj pointer w głównym repo (`git add modules && git commit -m "modules: update submodule"`).
- Przy świeżym klonie: `git submodule update --init --recursive`.
- Nigdy nie commituj sekretów/kluczy.
- Po istotnych zmianach warto sprawdzić poprawność: `nix flake check`, ewaluacja/build hosta przed switch (nh/build).