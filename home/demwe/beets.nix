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
        ignore_data = [
          "comments"
          "encoder"
          "tool"
          "encodedby"
          "media"
          "label"
          "catalognum"
          "script"
          "language"
          "country"
          "asin"
          "isrc"
          "barcode"
        ];
        languages = [ "en" "jp" ];
      };

      # List all plugins you want to use here
      plugins = [
        "discogs"
        "fetchart"
        "info"
        "mbsync"
        "scrub"
        "embedart"
        "spotify"
      ];

      # --- TAG MANAGEMENT ---
      scrub = {
        auto = true;
      };

      spotify = {
        mode = "list";
        tiebreak = "popularity";
        data_source_mismatch_penalty = 0.1;
      };

      discogs = {
        data_source_mismatch_penalty = 0.0;
      };

      musicbrainz = {
        data_source_mismatch_penalty = 0.5;
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
