{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;
    
    # Simple package definition - most plugins are included by default
    package = pkgs.beets;

    settings = {
      directory = "~/Music";
      library = "~/Music/library.db";

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
        fname = "cover";
        store_source = true;
        maxwidth = 1200;
        sources = [ "filesystem" "discogs" "itunes" "amazon" ];
      };

      embedart = {
        auto = true;
        ifempty = false; # Wymusza osadzenie nawet jeśli plik ma już jakąś okładkę
        remove_art = false;
      };

      # --- DIRECTORY STRUCTURE ---
      paths = {
        default = "$albumartist - $album ($year)/%if{disctotal,Disc $disc/}$track - $title";
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