{ config, ... }:

{
  # Expose repository templates in XDG Templates (~ /Templates by default).
  home.file."Templates" = {
    source = config.my.paths.resources + "/templates";
    recursive = true;
  };
}
