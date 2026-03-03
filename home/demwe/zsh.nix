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
      update-nixos = "sudo nixos-rebuild switch --upgrade --log-format bar-with-logs";
      update-channels = "sudo nix-channel --update";
      check-size = "du -sh";
      use = "nix-shell";
      nix-remove-garbage = "sudo nix-collect-garbage -d";
      gpu-status = "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status";
      gpu-panel = "nvidia-smi";
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
}
