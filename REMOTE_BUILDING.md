# Zdalne Budowanie - Konfiguracja

Ta wersja jest bardziej nixowa i opiera sie na:
- `my.remoteBuilder.config` dla hosta, ktory przyjmuje zewnetrzne buildy
- `my.remoteBuilder.buildHosts` jako lista hostow budujacych (jak w dokumentacji Nixa)

## Architektura

- Builder (PC): wlaczasz `my.remoteBuilder.config.enableExternalBuilding = true`
- Client (Laptop): dodajesz hosty do `my.remoteBuilder.buildHosts = [ ... ]`

## Konfiguracja hostow

### Builder (PC) - DemwEPC

W `hosts/DemwEPC/builder.nix`:

```nix
{ ... }:
{
  my.remoteBuilder.config = {
    enableExternalBuilding = true;
    maxJobs = "auto";
  };
}
```

### Client (Laptop) - NixBook

W `hosts/NixBook/builder.nix`:

```nix
{ ... }:
{
  my.remoteBuilder.buildHosts = [
    {
      hostName = "DemwEPC";
      user = "demwe";
      sshKey = "/root/.ssh/builder_key";
      system = "x86_64-linux";
      maxJobs = 0;
      speedFactor = 1;
      supportedFeatures = [ "kvm" "big-parallel" ];
      mandatoryFeatures = [ ];
    }
  ];
}
```

## Dlaczego takie defaulty sa bardziej uniwersalne

- `config.maxJobs = "auto"`: builder sam bierze wszystkie rdzenie
- `buildHosts[].maxJobs = 0`: klient nie ogranicza buildera, builder decyduje wg swojego `max-jobs`
- `speedFactor = 1`: neutralny default bez zgadywania wydajnosci
- `buildHosts = [ ]`: brak hardcodowania i brak wymuszonego remote-build bez konfiguracji

## Opcje modulu

### `my.remoteBuilder.config`

- `enableExternalBuilding` (bool, domyslnie `false`)
- `maxJobs` (int|string, domyslnie `"auto"`)
- `trustedUsers` (list of string, domyslnie `[ "root" ]`)

### `my.remoteBuilder.buildHosts` (lista)

Kazdy element listy wspiera:
- `hostName` (string, wymagane)
- `user` (string, domyslnie `"root"`)
- `sshKey` (string, domyslnie `"/root/.ssh/builder_key"`)
- `system` (string, domyslnie `"x86_64-linux"`)
- `maxJobs` (int, domyslnie `0`)
- `speedFactor` (int, domyslnie `1`)
- `supportedFeatures` (list of string, domyslnie `[ ]`)
- `mandatoryFeatures` (list of string, domyslnie `[ ]`)

## Kroki SSH

Uwaga: `~` oznacza home aktualnego uzytkownika shella. W tej instrukcji dla komend bez `sudo` to home uzytkownika `demwe` (np. `/home/demwe`). Dla roota sciezki sa podane jawnie jako `/root/...`.

### 1. Wygeneruj klucz na PC

```bash
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/builder_key -N "" -C "nix-builder-key"
chmod 600 ~/.ssh/builder_key
```

### 2. Dodaj klucz publiczny na PC

```bash
cat ~/.ssh/builder_key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### 3. Skopiuj klucz prywatny na laptop (dla root/nix-daemon)

```bash
sudo mkdir -p /root/.ssh
scp demwe@DemwEPC:~/.ssh/builder_key /tmp/builder_key
sudo mv /tmp/builder_key /root/.ssh/builder_key
sudo chmod 600 /root/.ssh/builder_key
```

### 4. Przebuduj hosty

```bash
sudo nixos-rebuild switch --flake .#DemwEPC
sudo nixos-rebuild switch --flake .#NixBook
```

## Uzycie

Na laptopie:

```bash
sudo nixos-rebuild switch --flake .#NixBook
```

## Weryfikacja

```bash
nix show-config | grep -A 20 "build-machines"
nix build .#nixosConfigurations.NixBook.config.system.build.toplevel --verbose 2>&1 | grep -i "building on\|offload"
```

## Fallback

Jesli builder jest offline, Nix probuje budowac lokalnie.
