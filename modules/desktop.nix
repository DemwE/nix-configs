{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.my.desktop = {
    # Default Terminal (command only; terminals typically don't use MIME)
    defaultTerminal = {
      command = mkOption {
        type = types.str;
        default = "kitty";
        description = "Command to launch the default terminal emulator (used in keybinds).";
        example = "alacritty";
      };
    };

    # Default Web Browser
    defaultBrowser = {
      command = mkOption {
        type = types.str;
        default = "brave";
        description = "Command to launch the default web browser (used in keybinds).";
        example = "firefox";
      };
      desktop = mkOption {
        type = types.str;
        default = "brave-browser.desktop";
        description = "Desktop ID for the default browser (used for XDG MIME associations).";
        example = "firefox.desktop";
      };
    };

    # Default Editor
    defaultEditor = {
      command = mkOption {
        type = types.str;
        default = "code";
        description = "Command to launch the default editor (used in keybinds).";
        example = "codium";
      };
      desktop = mkOption {
        type = types.str;
        default = "code.desktop";
        description = "Desktop ID for the default editor (used for XDG MIME associations).";
        example = "code.desktop";
      };
    };

    # Default File Manager
    defaultFileManager = {
      command = mkOption {
        type = types.str;
        default = "nemo";
        description = "Command to launch the default file manager (used in keybinds).";
        example = "nautilus";
      };
      desktop = mkOption {
        type = types.str;
        default = "nemo.desktop";
        description = "Desktop ID for the default file manager (used for XDG MIME associations).";
        example = "org.gnome.Nautilus.desktop";
      };
    };

    # Hyprland monitors list (passed straight to settings.monitor)
    monitors = mkOption {
      type = types.listOf types.str;
      default = [
        "DP-1,2560x1440@165,0x0,1"
        "HDMI-A-1,1920x1080@60,-1080x-150,1,transform,1"
      ];
      description = "List of Hyprland monitor definitions (as strings).";
      example = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
    };

    # Hyprland workspace-to-monitor mapping
    workspaces = mkOption {
      type = types.listOf types.str;
      default = [
        "1,monitor:DP-1"
        "2,monitor:DP-1"
        "3,monitor:DP-1"
        "4,monitor:DP-1"
        "5,monitor:DP-1"
        "6,monitor:DP-1"
        "7,monitor:DP-1"
        "8,monitor:HDMI-A-1"
      ];
      description = "List of Hyprland workspace assignments (strings like \"<n>,monitor:<name>\").";
      example = [
        "1,monitor:eDP-1"
        "2,monitor:eDP-1"
        "3,monitor:HDMI-A-1"
      ];
    };
  };
}
