{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
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
      # nfs mounts
      mount-nfs-public = "sudo mount /mnt/public";
      unmount-nfs-public = "sudo umount /mnt/public";

      # other
      cls = "clear";

      # GPU
      gpu-status = "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status";
      gpu-panel = "nvidia-smi";
      mode-hybrid = "supergfxctl --mode Hybrid";
      mode-integrated = "supergfxctl --mode Integrated";
      run-game = "nvidia-offload gamescope -w 1920 -h 1200 -W 3840 -H 2400 -F fsr -f -- %*";
    };

    initContent = "fastfetch";

    history.path = "${config.xdg.stateHome}/zsh/history";
    history.size = 10000;
  };

  home.activation.createShellXdgDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.cacheHome}/zsh"
    mkdir -p "${config.xdg.stateHome}/zsh"
  '';
}
