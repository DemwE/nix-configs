{
  pkgs-unstable ? null,
  ...
}:
{
  my.boot = {
    enable = true;
    kernel = "unstable";
  };
}
