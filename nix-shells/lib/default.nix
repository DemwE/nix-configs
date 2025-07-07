{
  name,
  pkgs ? import <nixpkgs> { },
  buildInputs ? [ ],
}:

let
  # Helper to get package name, version, and description
  getPkgName = pkg: pkg.pname or pkg.name or "unknown";
  getPkgVersion = pkg: if pkg ? version then pkg.version else "unknown";
  getPkgDescription = pkg: pkg.meta.description or "No description available";

  # Generate shell code for displaying package info in list-packages
  genDisplayPackageInfo = pkg: ''
    display_package_info "${getPkgName pkg}" \
                        "${if pkg ? version then "(${pkg.version})" else ""}" \
                        "${getPkgDescription pkg}" \
                        "${pkg}"
  '';

  # Generate shell code for package-info command
  genPackageInfoData = pkg: ''
    if [ "$SEARCH_PACKAGE" = "${getPkgName pkg}" ]; then
      show_package_info "${getPkgName pkg}" \
                        "${getPkgVersion pkg}" \
                        "${getPkgDescription pkg}" \
                        "${pkg}"
      exit 0
    fi
  '';

  # Generate list of available packages for package-info
  genAvailablePackage = pkg: "  • ${getPkgName pkg}";

  # Generate shell code for calculating package sizes
  genPackageSizeCalc = pkg: ''
    if [ -d "${pkg}" ]; then
      pkg_size=$(du -sb "${pkg}" 2>/dev/null | cut -f1)
      total_bytes=$(( total_bytes + pkg_size ))
    fi
  '';

  # Compose all generated shell snippets
  packageProcessingLogic = pkgs.lib.concatMapStringsSep "\n" genDisplayPackageInfo buildInputs;
  packageInfoData = pkgs.lib.concatMapStringsSep "\n" genPackageInfoData buildInputs;
  availablePackagesList = pkgs.lib.concatMapStringsSep "\n" genAvailablePackage buildInputs;
  packageSizeCalc = pkgs.lib.concatMapStringsSep "\n" genPackageSizeCalc buildInputs;
  packageCount = toString (builtins.length buildInputs);

  # Read and inject generated code into scripts
  baseScript = builtins.readFile ./list-packages.sh;
  finalScript =
    builtins.replaceStrings
      [ "PACKAGE_INFO_PLACEHOLDER" "TOTAL_SIZE_CALCULATION_PLACEHOLDER" ]
      [ packageProcessingLogic packageSizeCalc ]
      baseScript;

  packageInfoScript = builtins.readFile ./package-info.sh;
  finalPackageInfoScript =
    builtins.replaceStrings
      [ "PACKAGE_DATA_PLACEHOLDER" "AVAILABLE_PACKAGES_PLACEHOLDER" ]
      [ packageInfoData availablePackagesList ]
      packageInfoScript;

  envInfoScript = builtins.readFile ./env-info.sh;
  finalEnvInfoScript =
    builtins.replaceStrings
      [ "ENV_PACKAGES_PATHS_PLACEHOLDER" "ENV_PACKAGE_COUNT_PLACEHOLDER" ]
      [ packageSizeCalc packageCount ]
      envInfoScript;

  # Write shell scripts
  listPackagesScript = pkgs.writeShellScript "list-packages" ''
    export ENVIRONMENT_NAME="${name}"
    ${finalScript}
  '';

  packageInfoScriptBin = pkgs.writeShellScript "package-info" ''
    export ENVIRONMENT_NAME="${name}"
    ${finalPackageInfoScript}
  '';

  envInfoScriptBin = pkgs.writeShellScript "env-info" ''
    export ENVIRONMENT_NAME="${name}"
    ${finalEnvInfoScript}
  '';

  helpScript = pkgs.writeShellScript "help" ''
    export ENVIRONMENT_NAME="${name}"
    ${builtins.readFile ./help.sh}
  '';

in
{
  shellHook = ''
    echo
    echo "Starting ${name} environment"
    echo
    echo "💡 Type 'help' to see available commands"
    echo
    exec zsh
  '';

  buildInputs = [
    (pkgs.writeShellScriptBin "list-packages" ''exec ${listPackagesScript} "$@"'')
    (pkgs.writeShellScriptBin "package-info" ''exec ${packageInfoScriptBin} "$@"'')
    (pkgs.writeShellScriptBin "env-info" ''exec ${envInfoScriptBin} "$@"'')
    (pkgs.writeShellScriptBin "help" ''exec ${helpScript} "$@"'')
  ];
}
