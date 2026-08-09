{ config, pkgs, lib, ... }:

let
  bind = keys: dispatcher: {
    _args = [ keys (lib.generators.mkLuaInline dispatcher) ];
  };
  bindMouse = keys: dispatcher: {
    _args = [
      keys
      (lib.generators.mkLuaInline dispatcher)
      { mouse = true; }
    ];
  };
  exec = cmd: "hl.dsp.exec_cmd(${cmd})";
  q = s: "\"${s}\"";
  long = s: "[=[${s}]=]";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Terminal
      (bind "SUPER + Return" (exec (q "${pkgs.kitty}/bin/kitty")))
      # (bind "SUPER + SHIFT + Return" (exec (q "${pkgs.kitty}/bin/kitty -f")))
      # (bind "SUPER + T" (exec (q "${pkgs.kitty}/bin/kitty -F")))

      # Apps
      (bind "SUPER + D" (exec (q "rofi -show drun")))
      (bind "SUPER + SHIFT + F" (exec (q "${pkgs.nautilus}/bin/nautilus")))
      (bind "SUPER + SHIFT + E" (exec (q "${pkgs.neovim}/bin/nvim")))
      (bind "SUPER + SHIFT + W" (exec (q "${pkgs.brave}/bin/brave")))

      # Hyprland
      (bind "SUPER + Q" "hl.dsp.window.kill()")
      (bind "SUPER + C" "hl.dsp.window.kill()")
      (bind "CTRL + ALT + Delete" "hl.dsp.exit()")
      (bind "SUPER + F" "hl.dsp.window.fullscreen({ mode = 0 })")
      # (bind "SUPER + S" "hl.dsp.window.pseudo()")
      (bind "SUPER + Space" "hl.dsp.window.float({ action = \"toggle\" })")
      (bind "SUPER + Space" "hl.dsp.window.center()")
      (bind "SUPER + L" (exec (q "hyprlock")))
      (bind "SUPER + X" (exec (q "wlogout -b 4 -c 32")))
      # Screenshots (auto-save to Pictures/Screenshots and open in swappy)
      # Area (manual selection) using grim + slurp + swappy, with auto-save
      (bind "SUPER + SHIFT + S" (exec (long
        ''
          sh -c 'if [ -n "$XDG_SCREENSHOTS_DIR" ]; then dir="$XDG_SCREENSHOTS_DIR"; elif [ -n "$XDG_PICTURES_DIR" ]; then dir="$XDG_PICTURES_DIR/Screenshots"; else dir="$HOME/Pictures/Screenshots"; fi; mkdir -p "$dir"; f="$dir/$(date +%F_%H-%M-%S).png"; grim -g "$(slurp)" - | tee "$f" | swappy -f - -o "$f"'
        ''
      )))
      # Full screen with edit and auto-save
      (bind "SUPER + Print" (exec (long
        ''
          sh -c 'if [ -n "$XDG_SCREENSHOTS_DIR" ]; then dir="$XDG_SCREENSHOTS_DIR"; elif [ -n "$XDG_PICTURES_DIR" ]; then dir="$XDG_PICTURES_DIR/Screenshots"; else dir="$HOME/Pictures/Screenshots"; fi; mkdir -p "$dir"; f="$dir/$(date +%F_%H-%M-%S).png"; grim - | tee "$f" | swappy -f - -o "$f"'
        ''
      )))
      # Clipboard picker
      (bind "SUPER + V" (exec (q "cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy")))

      # Change Focus
      (bind "SUPER + left" "hl.dsp.focus({ direction = \"left\" })")
      (bind "SUPER + right" "hl.dsp.focus({ direction = \"right\" })")
      (bind "SUPER + up" "hl.dsp.focus({ direction = \"up\" })")
      (bind "SUPER + down" "hl.dsp.focus({ direction = \"down\" })")

      # Move Active
      (bind "SUPER + SHIFT + left" "hl.dsp.window.move({ direction = \"left\" })")
      (bind "SUPER + SHIFT + right" "hl.dsp.window.move({ direction = \"right\" })")
      (bind "SUPER + SHIFT + up" "hl.dsp.window.move({ direction = \"up\" })")
      (bind "SUPER + SHIFT + down" "hl.dsp.window.move({ direction = \"down\" })")

      # Resize Active
      (bind "SUPER + CTRL + left" "hl.dsp.window.resize({ x = -20, y = 0, relative = true })")
      (bind "SUPER + CTRL + right" "hl.dsp.window.resize({ x = 20, y = 0, relative = true })")
      (bind "SUPER + CTRL + up" "hl.dsp.window.resize({ x = 0, y = -20, relative = true })")
      (bind "SUPER + CTRL + down" "hl.dsp.window.resize({ x = 0, y = 20, relative = true })")

      # Move Active (Floating Only)
      (bind "SUPER + ALT + left" "hl.dsp.window.move({ x = -20, y = 0, relative = true })")
      (bind "SUPER + ALT + right" "hl.dsp.window.move({ x = 20, y = 0, relative = true })")
      (bind "SUPER + ALT + up" "hl.dsp.window.move({ x = 0, y = -20, relative = true })")
      (bind "SUPER + ALT + down" "hl.dsp.window.move({ x = 0, y = 20, relative = true })")

      # Switch between windows
      (bind "SUPER + Tab" "hl.dsp.window.cycle_next()")
      (bind "SUPER + Tab" "hl.dsp.window.bring_to_top()")

      # Workspaces
      (bind "SUPER + 1" "hl.dsp.focus({ workspace = 1 })")
      (bind "SUPER + 2" "hl.dsp.focus({ workspace = 2 })")
      (bind "SUPER + 3" "hl.dsp.focus({ workspace = 3 })")
      (bind "SUPER + 4" "hl.dsp.focus({ workspace = 4 })")
      (bind "SUPER + 5" "hl.dsp.focus({ workspace = 5 })")
      (bind "SUPER + 6" "hl.dsp.focus({ workspace = 6 })")
      (bind "SUPER + 7" "hl.dsp.focus({ workspace = 7 })")
      (bind "SUPER + 8" "hl.dsp.focus({ workspace = 8 })")

      # Send to Workspaces
      (bind "SUPER + SHIFT + 1" "hl.dsp.window.move({ workspace = 1 })")
      (bind "SUPER + SHIFT + 2" "hl.dsp.window.move({ workspace = 2 })")
      (bind "SUPER + SHIFT + 3" "hl.dsp.window.move({ workspace = 3 })")
      (bind "SUPER + SHIFT + 4" "hl.dsp.window.move({ workspace = 4 })")
      (bind "SUPER + SHIFT + 5" "hl.dsp.window.move({ workspace = 5 })")
      (bind "SUPER + SHIFT + 6" "hl.dsp.window.move({ workspace = 6 })")
      (bind "SUPER + SHIFT + 7" "hl.dsp.window.move({ workspace = 7 })")
      (bind "SUPER + SHIFT + 8" "hl.dsp.window.move({ workspace = 8 })")

      # Mouse Buttons
      (bindMouse "SUPER + mouse:272" "hl.dsp.window.drag()")
      (bindMouse "SUPER + mouse:273" "hl.dsp.window.resize()")
    ];
  };
}
