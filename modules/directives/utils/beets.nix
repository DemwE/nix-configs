pkgs: {
  beets = pkgs.beets.override {
    withFetchart = true;
    withEmbedart = true;
  };
}
