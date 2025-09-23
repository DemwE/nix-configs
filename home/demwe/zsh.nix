{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
        "sudo"
      ];
    };

    shellAliases = {
      # ls
      l = "ls -lFh";
      la = "ls -lAFh";
      lr = "ls -tRFh";
      lt = "ls -ltFh";
      ll = "ls -l";

      # nfs mounts
      mount-nfs-public = "sudo mount /mnt/public";
      unmount-nfs-public = "sudo umount /mnt/public";

      # other
      cls = "clear";
      update-nixos = "sudo nixos-rebuild switch --upgrade";
      update-channels = "sudo nix-channel --update";
      use = "nix-shell";
    };

    initContent = "fastfetch";

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

  home.packages = [
    pkgs.thefuck
  ];
}
