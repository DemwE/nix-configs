{ my, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Mateusz Czarnecki"; # legacy value
    userEmail = "mateuszczarnecki360@gmail.com"; # legacy value
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      core.editor = "nvim";
      diff.colormoved = "plain";
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = my.theme.flavor;
        line-numbers = true;
        navigate = true;
      };
    };
  };
}
