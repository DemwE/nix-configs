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

      # other
      cls = "clear";
      nupdate = "sudo nixos-rebuild switch";
      hupdate = "home-manager switch -b backup";
    };

    initContent = "fastfetch";

    history.size = 10000;
  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin";
  };

  home.packages = [
    pkgs.thefuck
  ];
}
