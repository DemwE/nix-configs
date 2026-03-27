{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;
    
    # Simple package definition - most plugins are included by default
    package = pkgs.custom.beets;

    settings = {
      directory = "~/Music";
      library = "~/Music/library.db";
      art_filename = "cover";

      import = {
        move = true;
        write = true;
        autotag = true;
        resume = "ask";
      };

      # List all plugins you want to use here
      plugins = [
        "discogs"
        "fetchart"
        "info"
        "mbsync"
        "scrub"
        "embedart"
      ];

      # --- TAG MANAGEMENT ---
      scrub = {
        auto = true;
      };

      item_fields = {
        comment = "";
        copyright = "";
        publisher = "";
        asin = "";
        barcode = "";
        isrc = "$isrc";
      };

      # --- ARTWORK ---
      fetchart = {
        auto = true;
        store_source = true;
        maxwidth = 2400;
        minwidth = 1000;
        high_resolution = true;
        enforce_ratio = true;
        sources = [ "filesystem" "itunes" "amazon" "discogs"];
      };

      embedart = {
        auto = true;
        ifempty = false;
        remove_art = false;
      };

      # --- DIRECTORY STRUCTURE ---
      paths = {
        default = "$albumartist - $album ($year)/Disc $disc/$track - $title";
      };

      # --- DATA HANDLING ---
      original_date = false;
      
      ui = {
        color = true;
      };

      musicbrainz = {
        useragent = "beets-nixos-user/1.0.0";
      };
    };
  };
}