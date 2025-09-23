{ my, ... }:
{
  xdg.configFile."theme/palette.json".text = builtins.toJSON my.theme.palette;
}
