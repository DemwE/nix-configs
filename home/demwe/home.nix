{ config, pkgs, ... }:

{
  imports = [
    ./home-configuration.nix
    ./session-vars.nix
    ./dconf.nix
    ./git.nix
    ./zsh.nix
    ./atuin.nix
    ./fastfetch.nix
    ./yazi.nix
    ./btop.nix
    ./neovim.nix
    ./gnome.nix
    ./java.nix
    ./python.nix
    ./nodejs.nix
    ./cpp.nix
    ./toolchains.nix
    ./ides.nix
    ./beets.nix
    ./eza.nix
    ./oh-my-posh.nix
    ./direnv.nix
    ./tamplates.nix
    ./packages.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    #   '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/demwe/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
