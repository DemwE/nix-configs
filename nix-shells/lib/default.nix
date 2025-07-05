{ name }:
{
  shellHook = ''
    echo
    echo "Starting ${name} environment"
    echo
    exec zsh
  '';
}