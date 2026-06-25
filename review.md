# Review konfiguracji NixOS

> Autor: opencode — data: 2026-06-25

---

## 🏗️ Architektura (bardzo dobra)

Ogólna struktura jest świetnie przemyślana:

- **`my.*` namespace** z typowanymi opcjami (`mkOption`/`mkEnableOption`) — wzorcowe podejście
- **Feature flagi** — czyste włączanie/wyłączanie funkcji per-host
- **Separacja** host (hardware/networking) ↔ features ↔ system ↔ user
- **Overlay `pkgs.unstable`** — wygodne mieszanie stabilnych i niestabilnych pakietów
- Polska lokalizacja: `Europe/Warsaw`, `pl` klawiatura, polskie locale

---

## 🔴 Krytyczne / Security

### 1. Zahardcodowany hash hasła

**Pliki:** `modules/users/demwe/default.nix:12`, `modules/users/admin/default.nix:10`

Ten sam hash `$6$wGYsg/...` w obu użytkownikach (`demwe` i `admin`). Jeśli repo trafi do publicznego GitHub, każdy może próbować złamać hasło offline (atak słownikowy / brute-force). Nawet jeśli repo nie jest publiczne — trzymanie hashy w plaintekście to zła praktyka.

**Rekomendacja:** Użyj `sops-nix` lub `agenix` do zarządzania sekretami. Hash hasła możesz zastąpić przez `users.users.<name>.initialPassword = "changeme"` (wymusi zmianę przy pierwszym logowaniu) albo wczytać z sops-a.

### 2. Brak zarządzania sekretami

Brak `sops-nix`, `agenix` lub `git-crypt` w całym projekcie. Wraz ze wzrostem liczby hostów i usług (VPN, WireGuard, klucze API, hasła) będzie to coraz bardziej bolesne.

**Rekomendacja:** Dodaj `sops-nix` (najpopularniejsze w ekosystemie NixOS) i trzymaj tylko zaszyfrowane sekrety w repo.

---

## 🟡 Średnie problemy

### 3. `stateVersion` jako zmienna globalna

**Pliki:** `flake.nix:24`, `configuration.nix:11`

```nix
systemVersion = "26.05";
# ...
system.stateVersion = systemVersion;
```

`system.stateVersion` powinien być **ustawiony raz przy instalacji i nigdy nie zmieniany**. Używanie zmiennej `systemVersion` do jego ustawiania grozi przypadkową zmianą przy upgradzie, co może połamać system (np. zmiana domyślnych ścieżek, formatów plików konfiguracyjnych itp.).

**Rekomendacja:** Zdefiniuj `stateVersion` per-host, albo przynajmniej zrób:
```nix
system.stateVersion = "26.05"; # ustawiony przy instalacji, NIE ZMIENIAĆ
```
z dużym komentarzem ostrzegawczym.

### 4. `pkgs` w flake.nix — zbędny import

**Plik:** `flake.nix:27-34`

```nix
pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
```

Te importy są tworzone na górze `flake.nix`, ale:
- Są używane tylko w `devShell` (`pkgs.nixfmt`)
- NixOS module system sam stworzy `pkgs` dla każdej konfiguracji
- Overlay `nixosModule` zamyka `pkgs-unstable` w closure, więc jest ono dostępne bez tego importu

**Rekomendacja:** Usuń `pkgs` i `pkgs-unstable` z top-level `let`, a w devShell użyj `nixpkgs.legacyPackages.x86_64-linux`.

### 5. `nix-flatpak` pobierany poza flake lock

**Plik:** `modules/features/desktop/flatpak.nix:2-5`

```nix
nix-flatpak = builtins.fetchTarball {
  url    = "https://github.com/gmodena/nix-flatpak/archive/refs/tags/v0.7.0.tar.gz";
  sha256 = "1jsxx20jv2dmf75563i9ldyva99d0qcls2rm424ikx83hnasx47d";
};
```

`builtins.fetchTarball` z pinu SHA256 jest lepsze niż goły URL, ale **nadal nie jest pinowane w `flake.lock`**. Przy rebuildzie Nix pobierze tarball, zweryfikuje hash (ok), ale nie ma centralnego śledzenia wersji.

**Rekomendacja:** Dodaj `nix-flatpak` jako input w `flake.nix`:
```nix
nix-flatpak.url = "github:gmodena/nix-flatpak/v0.7.0";
```

### 6. Overlay z `pkgs-unstable` ma fixed system

**Plik:** `flake.nix:31-34` i `flake.nix:40-44`

```nix
pkgs-unstable = import nixpkgs-unstable {
  system = "x86_64-linux";  # hardcoded
  config.allowUnfree = true;
};
```

Przy próbie cross-compilacji to nie zadziała, bo `system` jest na sztywno.

**Rekomendacja:** Przenieś import do overlaya i użyj `pkgs.system`:
```nix
nixosModule = { pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (pkgs) system;
        config.allowUnfree = true;
      };
    })
  ];
};
```

### 7. `allowUnfree` ustawione w dwóch miejscach

**Pliki:** `flake.nix:29,33` oraz `configuration.nix:8`

`nixpkgs.config.allowUnfree = true;` jest ustawione przy `import nixpkgs` w flake.nix i ponownie w configuration.nix. To w configuration.nix jest właściwym miejscem — wpływa na NixOS module system. To w flake.nix przy imporcie nie ma wpływu na system.

**Rekomendacja:** Usuń `config.allowUnfree = true` z importów w `flake.nix` (linie 29 i 33). Zostaw tylko w `configuration.nix`.

### 8. SSH host keys a preservation

**Pliki:** `hosts/NixBook/preservation.nix`, `modules/common/services/default.nix:20-23`

SSH host keys są ustawione na `/persist/ssh/ssh_host_*` ale katalog `/persist/ssh` nie jest wymieniony w `preserveAt.directories`. Ponieważ `/persist` jest na własnym subvolumie BTRFS (`@persist`), dane na nim powinny przetrwać reboot, ale warto dodać jawnie dla jasności i dokumentacji.

**Rekomendacja:** Dodaj `/persist/ssh` do `preserveAt.directories` lub przynajmniej komentarz.

---

## 🟢 Drobne uwagi

### 9. Steam + supergfxctl — brak gwarancji dostępności

**Plik:** `modules/features/desktop/steam.nix:20`

```nix
extraProfile = ''
  MODE=$(${pkgs.supergfxctl}/bin/supergfxctl --get 2>/dev/null || echo "Hybrid")
  ...
```
Steam woła `supergfxctl`, ale tylko NixBook ma `supergfxd.enable = true`. Na DemwEPC i N1 ten pakiet nie będzie dostępny w build time.

**Rekomendacja:** Uzależnij tę część od `config.my.features.supergfxd.enable`, albo użyj `lib.optionalString`.

### 10. Audio 192kHz / 32-bit — domyślnie

**Plik:** `modules/system/hardware/audio.nix:14-26`

```nix
"default.clock.rate" = 192000;
"pulse.default.format" = "S32LE";
```

Domyślne sample rate 192kHz i 32-bit mogą powodować problemy z:
- Bluetooth słuchawkami (często wspierają tylko 48kHz)
- Starszym sprzętem
- Zwiększonym zużyciem CPU

**Rekomendacja:** Rozważ zrobienie z tego opcji (`my.audio.quality = "high" | "normal"`), albo zostaw z komentarzem.

### 11. Fancontrol — hardcodowane ścieżki hwmon

**Plik:** `hosts/N1/other.nix:6-15`

```nix
FCTEMPS=/sys/class/hwmon/hwmon0/pwm1=...
FCFANS=/sys/class/hwmon/hwmon0/pwm1=...
```

Indeksy `hwmon0` mogą się zmieniać między wersjami kernela, po dodaniu/odłączeniu sprzętu, itp.

**Rekomendacja:** Użyj ścieżek z nazwą urządzenia (np. `hwmon*/name` da `nct6775`), ale to może być trudne w `fancontrol`. Przynajmniej dodaj komentarz ostrzegawczy, że trzeba zweryfikować ścieżki po upgrade kernela.

### 12. `boot.tmp.useTmpfs = true` + 26G

**Pliki:** `hosts/NixBook/boot.nix:3-4`, `hosts/DemwEPC/boot.nix:3-4`

```nix
boot.tmp.useTmpfs = true;
boot.tmp.tmpfsSize = "26G";
```

Wymaga minimum ~32GB RAM. Jeśli masz tyle, jest OK, ale warto być świadomym.

### 13. Literówka: "tamplates"

**Plik:** `home/demwe/tamplates.nix`

Nazwa pliku i modułu: powinno być `templates` (przez `e`), nie `tamplates` (przez `a`).

### 14. `nix.settings.cores = 0`

**Plik:** `modules/system/core/nix-settings.nix:9`

`cores = 0` oznacza "użyj wszystkich rdzeni". Działa, ale jest to mało czytelna special value — domyślnie NixOS i tak używa wszystkich rdzeni.

**Rekomendacja:** Usuń tę linię albo zmień na `cores = 0;` z komentarzem.

### 15. GC zbyt agresywny?

**Plik:** `modules/system/core/nix-settings.nix:2-6`

```nix
nix.gc = {
  automatic = true;
  dates = "daily";
  options = "--delete-older-than 5d";
};
```

Codzienne GC z usuwaniem starszych niż 5 dni może powodować codzienny I/O spike. Działa też `auto-optimise-store = true`, co dodatkowo konsumuje I/O.

**Rekomendacja:** Rozważ rzadsze GC (np. `weekly`) lub dłuższy okres (np. `14d`), chyba że masz mało miejsca na dysku.

---

## ✅ Co jest świetne

### Liberica JDK builder
`modules/directives/liberiaJDK/schema.nix` — imponujący, własny builder dla 7 wersji JDK (8–25) z `autoPatchelf`, versioned wrapperami. Bardzo przydatne dla IntelliJ.

### Power profiles z hookami
`modules/system/hardware/power-profiles.nix` — zgrabny system: PPD + custom hook (`ppd-hook`) monitorujący D-Bus do aplikowania dodatkowych ustawień (NVIDIA PCIe power control, turbo) przy zmianie profilu. Do tego skrypty `power-save`/`balanced`/`performance` z sudo NOPASSWD i `power-status` do podglądu.

### Preservation + BTRFS rollback w initrd
`hosts/NixBook/preservation.nix` — solidna konfiguracja impermanence: rollback subvolumenu `@root` przed mountem, zachowanie ostatnich 4 snapshots, persist dla `/var/lib/*`. Wszystko w initrd z `systemd.initrd`.

### Catppuccin theme system
`modules/theme/core.nix` — czysty system: centralna paleta `palettes.mocha`, opcje `flavor`/`accent`/`font`, automatyczne derivowanie nazw pakietów GTK/SDDM. Wykorzystane w btop, yazi, eza.

### Toolchain symlinks dla IDE
- `home/demwe/toolchains.nix` — ~/.toolchains/ dla CLion, RustRover, Rider
- `home/demwe/java.nix` — ~/.jdks/ do Liberici
- `home/demwe/python.nix` — ~/.pyenv/versions/
- `home/demwe/nodejs.nix` — ~/.nvm/versions/

Świetne dla JetBrains IDE, które automatycznie wykrywają te ścieżki.

### Remote builder module
`modules/system/remote-builder.nix` — kompletny system do distributed builds z opcjami dla build hostów, kluczy SSH, feature flags. Gotowy do użycia.

### NFS + RAID + fancontrol na N1
Widać że serwer to prawdziwy homelab: mdadm RAID0, NFS export, it87 kernel module, fancontrol. Konkretnie.

---

## Podsumowanie

Ogólnie config jest **bardzo dobry** — czysty, modularny, z typowanymi opcjami. Widać doświadczenie z NixOS.

### Priorytety do poprawy:

| Priorytet | Co | Status |
|-----------|-----|--------|
| 🔴 | Sekrety (hasła w plaintext) | **Do poprawy** |
| 🟡 | `nix-flatpak` poza flake lock | Do poprawy |
| 🟡 | `stateVersion` globalne (ryzyko) | Do przemyślenia |
| 🟡 | Zbędny import `pkgs` w flake.nix | Kosmetyka |
| 🟡 | Overlay z hardcoded system | Przy cross-compilacji |
| 🟢 | Literówka "tamplates" | Kosmetyka |
| 🟢 | Audio 192kHz default | Potencjalny problem |
| 🟢 | Fancontrol ścieżki | Przy kolejnym upgrade kernela |
| ✅ | Reszta — działa i jest dobrze napisane | 👍 |

---

*Review wygenerowany automatycznie przez opencode.*
