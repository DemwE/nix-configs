{ name, pkgs ? import <nixpkgs> {}, buildInputs ? [] }:
let
  list-packages = pkgs.writeShellScriptBin "list-packages" ''
    echo "📦 Declared packages in ${name}:"
    echo "================================================="
    
    # List the explicitly declared buildInputs
    ${pkgs.lib.concatMapStringsSep "\n" (pkg: 
      "echo \"• ${pkg.pname or pkg.name or "unknown"}${pkgs.lib.optionalString (pkg ? version) " (${pkg.version})"}\""
    ) buildInputs}
    
    echo
    echo "💡 Use 'which <command>' to see the full path of a specific command"
    echo "💡 Use 'nix-store -q --tree \$NIX_STORE_PATH' for dependency tree"
  '';
in
{
  shellHook = ''
    echo
    echo "Starting ${name} environment"
    echo
    echo "💡 Type 'list-packages' to see declared packages"
    echo
    exec zsh
  '';
  
  buildInputs = [ list-packages ];
}
