-- Terminal
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
-- hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("kitty -f"))
-- hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty -F"))

-- Apps
hl.bind("SUPER + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("nvim"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("brave"))

-- Hyprland
hl.bind("SUPER + Q", hl.dsp.window.kill())
hl.bind("SUPER + C", hl.dsp.window.kill())
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = 0 }))
-- hl.bind("SUPER + S", hl.dsp.window.pseudo())
hl.bind("SUPER + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Space", hl.dsp.window.center())
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("wlogout -b 4 -c 32"))

-- Screenshots (auto-save to Pictures/Screenshots and open in swappy)
-- Area (manual selection) using grim + slurp + swappy, with auto-save
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd([=[
sh -c 'if [ -n "$XDG_SCREENSHOTS_DIR" ]; then dir="$XDG_SCREENSHOTS_DIR"; elif [ -n "$XDG_PICTURES_DIR" ]; then dir="$XDG_PICTURES_DIR/Screenshots"; else dir="$HOME/Pictures/Screenshots"; fi; mkdir -p "$dir"; f="$dir/$(date +%F_%H-%M-%S).png"; grim -g "$(slurp)" - | tee "$f" | swappy -f - -o "$f"'
]=]))
-- Full screen with edit and auto-save
hl.bind("SUPER + Print", hl.dsp.exec_cmd([=[
sh -c 'if [ -n "$XDG_SCREENSHOTS_DIR" ]; then dir="$XDG_SCREENSHOTS_DIR"; elif [ -n "$XDG_PICTURES_DIR" ]; then dir="$XDG_PICTURES_DIR/Screenshots"; else dir="$HOME/Pictures/Screenshots"; fi; mkdir -p "$dir"; f="$dir/$(date +%F_%H-%M-%S).png"; grim - | tee "$f" | swappy -f - -o "$f"'
]=]))

-- Clipboard picker
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy"))

-- Change Focus
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Move Active
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize Active
hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

-- Move Active (Floating Only)
hl.bind("SUPER + ALT + left", hl.dsp.window.move({ x = -20, y = 0, relative = true }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ x = 20, y = 0, relative = true }))
hl.bind("SUPER + ALT + up", hl.dsp.window.move({ x = 0, y = -20, relative = true }))
hl.bind("SUPER + ALT + down", hl.dsp.window.move({ x = 0, y = 20, relative = true }))

-- Switch between windows
hl.bind("SUPER + Tab", hl.dsp.window.cycle_next())
hl.bind("SUPER + Tab", hl.dsp.window.bring_to_top())

-- Workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))

-- Send to Workspaces
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))

-- Mouse Buttons
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
