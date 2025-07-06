{ name, pkgs ? import <nixpkgs> {}, buildInputs ? [] }:
let
  # Generate the package processing logic for list-packages
  packageProcessingLogic = pkgs.lib.concatMapStringsSep "\n" (pkg: 
    let
      nixName = pkg.pname or pkg.name or "unknown";
      version = if pkg ? version then " (${pkg.version})" else "";
      description = pkg.meta.description or "No description available";
    in
    ''display_package_info "${nixName}" "${version}" "${description}" "${pkg}"''
  ) buildInputs;
  
  # Generate package data for package-info command
  packageInfoData = pkgs.lib.concatMapStringsSep "\n" (pkg:
    let
      nixName = pkg.pname or pkg.name or "unknown";
      version = if pkg ? version then pkg.version else "unknown";
      description = pkg.meta.description or "No description available";
    in
    ''
if [ "$SEARCH_PACKAGE" = "${nixName}" ]; then
    show_package_info "${nixName}" "${version}" "${description}" "${pkg}"
    exit 0
fi''
  ) buildInputs;
  
  # Generate available packages list for package-info
  availablePackagesList = pkgs.lib.concatMapStringsSep "\n" (pkg:
    let nixName = pkg.pname or pkg.name or "unknown"; in
    "  • ${nixName}"
  ) buildInputs;
  
  # Read the base script and inject the package processing logic
  baseScript = builtins.readFile ./list-packages.sh;
  finalScript = builtins.replaceStrings 
    ["PACKAGE_INFO_PLACEHOLDER"] 
    [packageProcessingLogic] 
    baseScript;
  
  # Read the package-info script and inject package data
  packageInfoScript = builtins.readFile ./package-info.sh;
  finalPackageInfoScript = builtins.replaceStrings 
    ["PACKAGE_DATA_PLACEHOLDER" "AVAILABLE_PACKAGES_PLACEHOLDER"] 
    [packageInfoData availablePackagesList] 
    packageInfoScript;
  
  list-packages = pkgs.writeShellScript "list-packages" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalScript}
  '';
  
  package-info = pkgs.writeShellScript "package-info" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalPackageInfoScript}
  '';
in
{
  shellHook = ''
    echo
    echo "Starting ${name} environment"
    echo
    echo "💡 Type 'list-packages' to see declared packages"
    echo "💡 Type 'package-info <name>' for detailed package information"
    echo
    exec zsh
  '';
  
  buildInputs = [ 
    (pkgs.writeShellScriptBin "list-packages" ''exec ${list-packages} "$@"'')
    (pkgs.writeShellScriptBin "package-info" ''exec ${package-info} "$@"'')
  ];
}
