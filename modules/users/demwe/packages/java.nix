{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    custom.java25.versioned
    custom.java21.versioned
    custom.java17.versioned
    custom.java11.versioned
    custom.java8.versioned
  ];
}
