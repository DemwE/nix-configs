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
  
  # Generate package count and size calculation for env-info
  packageCount = toString (builtins.length buildInputs);
  packageSizeCalc = pkgs.lib.concatMapStringsSep "\n" (pkg:
    ''
    if [ -d "${pkg}" ]; then
        pkg_size=$(du -sb "${pkg}" 2>/dev/null | cut -f1)
        total_bytes=$(( total_bytes + pkg_size ))
    fi''
  ) buildInputs;
  
  # Generate total size calculation for list-packages
  totalSizeCalc = pkgs.lib.concatMapStringsSep "\n" (pkg:
    ''
    if [ -d "${pkg}" ]; then
        pkg_size=$(du -sb "${pkg}" 2>/dev/null | cut -f1)
        total_bytes=$(( total_bytes + pkg_size ))
    fi''
  ) buildInputs;
  
  # Read the base script and inject the package processing logic
  baseScript = builtins.readFile ./list-packages.sh;
  finalScript = builtins.replaceStrings 
    ["PACKAGE_INFO_PLACEHOLDER" "TOTAL_SIZE_CALCULATION_PLACEHOLDER"] 
    [packageProcessingLogic totalSizeCalc] 
    baseScript;
  
  # Read the package-info script and inject package data
  packageInfoScript = builtins.readFile ./package-info.sh;
  finalPackageInfoScript = builtins.replaceStrings 
    ["PACKAGE_DATA_PLACEHOLDER" "AVAILABLE_PACKAGES_PLACEHOLDER"] 
    [packageInfoData availablePackagesList] 
    packageInfoScript;
  
  # Read the env-info script and inject environment data
  envInfoScript = builtins.readFile ./env-info.sh;
  finalEnvInfoScript = builtins.replaceStrings 
    ["ENV_PACKAGES_PATHS_PLACEHOLDER" "ENV_PACKAGE_COUNT_PLACEHOLDER"] 
    [packageSizeCalc packageCount] 
    envInfoScript;
  
  list-packages = pkgs.writeShellScript "list-packages" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalScript}
  '';
  
  package-info = pkgs.writeShellScript "package-info" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalPackageInfoScript}
  '';
  
  env-info = pkgs.writeShellScript "env-info" ''
    export ENVIRONMENT_NAME="${name}"
    
    ${finalEnvInfoScript}
  '';
in
{
  shellHook = ''
    echo
    echo "Starting ${name} environment"
    echo
    echo "💡 Type 'list-packages' to see declared packages"
    echo "💡 Type 'package-info <name>' for detailed package information"
    echo "💡 Type 'env-info' for environment summary"
    echo
    exec zsh
  '';
  
  buildInputs = [ 
    (pkgs.writeShellScriptBin "list-packages" ''exec ${list-packages} "$@"'')
    (pkgs.writeShellScriptBin "package-info" ''exec ${package-info} "$@"'')
    (pkgs.writeShellScriptBin "env-info" ''exec ${env-info} "$@"'')
  ];
}
