{ config, lib, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    ZDOTDIR = "${config.xdg.configHome}/zsh";
    HISTFILE = "${config.xdg.stateHome}/zsh/history";
    ZSH_COMPDUMP = "${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION";
  };

  programs.zsh = {
    dotDir = ".config/zsh";
    history.path = "${config.xdg.stateHome}/zsh/history";
  };

  home.activation.createShellXdgDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.cacheHome}/zsh"
    mkdir -p "${config.xdg.stateHome}/zsh"
  '';
}