{ ... }:
{
  # Aggregate core system modules for simpler host import.
  imports = [
    ./locale-input.nix
    ./nix-settings.nix
    ./shell.nix
    ./fonts.nix
    ./audio.nix
    ./housekeeping.nix
  ];
}
