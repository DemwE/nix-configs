{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;

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
        "spootify"
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
        highest_resolution = true;
        maxwidth = 2400;
        minwidth = 1600;
        sources = [
          "itunes"
          "filesystem"
          "amazon"
          "discogs"
        ];
      };

      embedart = {
        auto = true;
        ifempty = false;
        remove_art = true;
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