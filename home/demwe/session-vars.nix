{ config, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    # Node.js
    NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/npm-init.js";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    # Android
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    # .NET
    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet-cli";
    # NVM
    NVM_DIR = "${config.xdg.dataHome}/nvm";
    # Gradle
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    # CUDA
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
  };
}
