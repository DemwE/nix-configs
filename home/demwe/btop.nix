{ config, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin";
    };
    themes = {
      catppuccin = let p = config.my.theme.palette; in ''
        # Central palette (Catppuccin ${config.my.theme.flavor})
        theme[main_bg]="${p.base}"

        # Main text color
  theme[main_fg]="${p.text}"

        # Title color for boxes
  theme[title]="${p.text}"

        # Highlight color for keyboard shortcuts
  theme[hi_fg]="${p.blue}"

        # Background color of selected item in processes box
  theme[selected_bg]="${p.surface1}"

        # Foreground color of selected item in processes box
  theme[selected_fg]="${p.blue}"

        # Color of inactive/disabled text
  theme[inactive_fg]="${p.overlay1}"

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
  theme[graph_text]="${p.rosewater}"

        # Background color of the percentage meters
  theme[meter_bg]="${p.surface1}"

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
  theme[proc_misc]="${p.rosewater}"

        # CPU, Memory, Network, Proc box outline colors
  theme[cpu_box]="${p.mauve}"
  theme[mem_box]="${p.green}"
  theme[net_box]="${p.maroon}"
  theme[proc_box]="${p.blue}"

        # Box divider line and small boxes line color
  theme[div_line]="${p.overlay0}"

        # Temperature graph color (Green -> Yellow -> Red)
  theme[temp_start]="${p.green}"
  theme[temp_mid]="${p.yellow}"
  theme[temp_end]="${p.red}"

        # CPU graph colors (Teal -> Lavender)
  theme[cpu_start]="${p.teal}"
  theme[cpu_mid]="${p.sapphire}"
  theme[cpu_end]="${p.lavender}"

        # Mem/Disk free meter (Mauve -> Lavender -> Blue)
  theme[free_start]="${p.mauve}"
  theme[free_mid]="${p.lavender}"
  theme[free_end]="${p.blue}"

        # Mem/Disk cached meter (Sapphire -> Lavender)
  theme[cached_start]="${p.sapphire}"
  theme[cached_mid]="${p.blue}"
  theme[cached_end]="${p.lavender}"

        # Mem/Disk available meter (Peach -> Red)
  theme[available_start]="${p.peach}"
  theme[available_mid]="${p.maroon}"
  theme[available_end]="${p.red}"

        # Mem/Disk used meter (Green -> Sky)
  theme[used_start]="${p.green}"
  theme[used_mid]="${p.teal}"
  theme[used_end]="${p.sky}"

        # Download graph colors (Peach -> Red)
  theme[download_start]="${p.peach}"
  theme[download_mid]="${p.maroon}"
  theme[download_end]="${p.red}"

        # Upload graph colors (Green -> Sky)
  theme[upload_start]="${p.green}"
  theme[upload_mid]="${p.teal}"
  theme[upload_end]="${p.sky}"

        # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
        theme[process_start]="${p.sapphire}"
        theme[process_mid]="${p.lavender}"
        theme[process_end]="${p.mauve}"
      '';
    };
  };
}
