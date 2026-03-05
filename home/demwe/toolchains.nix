{ pkgs, ... }:
{
  # ~/.toolchains/<name> → nix store derivation (managed by home-manager)
  # home-manager updates the symlink on every rebuild → path is always stable.
  # IDEs point at ~/.toolchains/<name> directly; terminal gets PATH via sessionPath.
  home.file = {
    ".toolchains/cpp".source = pkgs.custom.toolchain-cpp;
    ".toolchains/rust".source = pkgs.custom.toolchain-rust;
    ".toolchains/python".source = pkgs.custom.toolchain-python;
    ".toolchains/dotnet".source = pkgs.custom.toolchain-dotnet;
    ".toolchains/nodejs".source = pkgs.custom.toolchain-nodejs;
  };

  # Added to the systemd user session environment — inherited by ALL processes:
  # bash, zsh, fish, GNOME apps, IDE processes, scripts, etc.
  home.sessionPath = [
    # Rust
    "$HOME/.cargo/bin"
    "$HOME/.toolchains/rust/bin"
    # C++
    "$HOME/.toolchains/cpp/bin"
    # Python
    "$HOME/.toolchains/python/bin"
    # .NET
    "$HOME/.toolchains/dotnet/bin"
    # Node.js
    "$HOME/.toolchains/nodejs/bin"
  ];
}
