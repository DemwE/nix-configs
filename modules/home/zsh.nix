{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # legacy setting
    autosuggestion.enable = false; # legacy had it disabled
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "sudo" ];
    };

    shellAliases = {
      l = "ls -lFh";
      la = "ls -lAFh";
      lr = "ls -tRFh";
      lt = "ls -ltFh";
      ll = "ls -l";
      mount-nfs-public = "sudo mount /mnt/public";
      unmount-nfs-public = "sudo umount /mnt/public";
      cls = "clear";
      # Flake-based workflow aliases
      flake-update = "nix flake update";
      update-nixos = "sudo nixos-rebuild switch --flake .#DemwE_PC";
      update-home-manager = "home-manager switch --flake .#demwe";
      update-all = "nix flake update && sudo nixos-rebuild switch --flake .#DemwE_PC";
      # Convenience / maintenance
      diff-lock = "git diff flake.lock";
      gc-old = "sudo nix-collect-garbage -d";
      store-opt = "nix store optimise";
      # Legacy compatibility (old names mapped to new behavior)
      update-channels = "echo 'Channels deprecated; use flake-update'";
      use = "nix-shell";
    };

    initContent = ''
      fastfetch
    '';

    history.size = 10000;

    profileExtra = ''
      _use_completion() {
        _files -W ${"~/nix-shells/"} -g '*.nix'
      }
      compdef _use_completion use
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin";
  };

  home.packages = [ pkgs.thefuck ];
}
