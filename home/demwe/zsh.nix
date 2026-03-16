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

      # Update aliases (works with ~/nix-configs -> /etc/nixos symlink)
      update = "cd /etc/nixos && git pull && sudo nixos-rebuild switch --flake . --log-format bar-with-logs";
      update-check = "cd /etc/nixos && git pull && nix flake check";
      switch = "cd /etc/nixos && git pull && sudo nixos-rebuild switch --flake . --log-format bar-with-logs";

      gpu-status = "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status";
      gpu-panel = "nvidia-smi";
      mode-hybrid = "supergfxctl --mode Hybrid";
      mode-integrated = "supergfxctl --mode Integrated";
      run-game = "nvidia-offload gamescope -w 1920 -h 1200 -W 3840 -H 2400 -F fsr -f -- %*";
    };

    initContent = "fastfetch";

    history.size = 10000;
  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin";
  };
}
