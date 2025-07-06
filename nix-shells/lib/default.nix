{ name, pkgs ? import <nixpkgs> {}, buildInputs ? [] }:
let
  # Generate the package processing logic
  packageProcessingLogic = pkgs.lib.concatMapStringsSep "\n" (pkg: 
    let
      nixName = pkg.pname or pkg.name or "unknown";
      version = if pkg ? version then " (${pkg.version})" else "";
      description = pkg.meta.description or "No description available";
    in
    ''display_package_info "${nixName}" "${version}" "${description}" "${pkg}"''
  ) buildInputs;
  
  # Read the base script and inject the package processing logic
  baseScript = builtins.readFile ./list-packages.sh;
  finalScript = builtins.replaceStrings 
    ["PACKAGE_INFO_PLACEHOLDER"] 
    [packageProcessingLogic] 
    baseScript;
  
  list-packages = pkgs.writeShellScript "list-packages" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalScript}
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
  
  buildInputs = [ 
    (pkgs.writeShellScriptBin "list-packages" ''exec ${list-packages} "$@"'')
  ];
}
