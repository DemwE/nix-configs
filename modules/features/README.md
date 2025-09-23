Feature flags pattern:

Each file exports options under `my.features.<name>.enable`.
Host config sets booleans like:
  my.features.docker.enable = true;

This keeps service logic decoupled and reusable in profiles.
