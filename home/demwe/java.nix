# Expose all Liberica JDK versions to IntelliJ IDEA via ~/.jdks/
# IDEA automatically scans ~/.jdks/ since version 2020.1 — no manual setup needed.
{ pkgs, ... }:
let
  jdks = {
    "liberica-8"  = pkgs.custom.java8.passthru.jdk;
    "liberica-11" = pkgs.custom.java11.passthru.jdk;
    "liberica-17" = pkgs.custom.java17.passthru.jdk;
    "liberica-21" = pkgs.custom.java21.passthru.jdk;
    "liberica-25" = pkgs.custom.java25.passthru.jdk;
  };
in
{
  home.file = builtins.listToAttrs (
    map (name: {
      name  = ".jdks/${name}";
      value = { source = jdks.${name}; };
    }) (builtins.attrNames jdks)
  );
}
