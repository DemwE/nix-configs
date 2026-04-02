{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gh
    nixfmt-rfc-style
    custom.rust-rover
    custom.webstorm
    custom.pycharm
    custom.clion
    custom.rider
    custom.idea
    custom.datagrip
    unstable.vscode
    unstable.unityhub
    unstable.opencode
    unstable.zed-editor
    custom.toolchain-arm
    unstable.arduino-ide
  ];
}
