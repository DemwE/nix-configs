{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;
    
    # Override the default package to ensure we have the necessary plugins enabled
    package = pkgs.beets.override {
      pluginOverrides = {
        discogs = { enable = true; };
        fetchart = { enable = true; };
        scrub = { enable = true; };
      };
    };

    settings = {
      directory = "~/Music";      # Where your processed music will live
      library = "~/Music/library.db"; # Beets internal database location

      import = {
        move = true;               # Move files from source to destination
        write = true;              # Write metadata tags to the files
        autotag = true;            # Search for metadata automatically
        resume = "ask";            # Ask to resume interrupted imports
      };

      # Essential plugins for your workflow
      plugins = [
        "discogs"   # Better metadata for niche/electronic/modern releases
        "fetchart"  # Downloads cover.jpg
        "info"      # Allows checking tags with 'beet info'
        "mbsync"    # Syncs extra info from MusicBrainz (like ISRC)
        "scrub"     # Cleans existing tags before writing new ones
      ];

      # --- TAG MANAGEMENT ---

      # The 'scrub' plugin removes all non-essential tags
      scrub = {
        auto = true;
      };

      # Manually zero out tags you explicitly don't want
      item_fields = {
        comment = "''";
        copyright = "''";
        publisher = "''";
      };

      # --- ARTWORK ---

      fetchart = {
        auto = true;
        fname = "cover"; # Saves as 'cover.jpg' exactly as in your example
      };

      # --- DIRECTORY STRUCTURE (Your specific Pattern) ---
      # Logic: Artist - Album (Year) / [Disc X /] Track - Title
      paths = {
        default = "$albumartist - $album ($year)/%if{disctotal,Disc $disc/}$track - $title";
      };

      # --- DATA HANDLING ---

      # Forces Beets to use only the Year part for the $year field
      original_date = false; # Set to true if you prefer the original release year
      
      # UI settings for a better terminal experience
      ui = {
        color = true;
      };

      # Required for MusicBrainz/Discogs API identification
      musicbrainz = {
        # Using a generic user agent for the API
        useragent = "beets-nixos-user/1.0.0";
      };
    };
  };
}