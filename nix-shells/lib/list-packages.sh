#!/bin/bash

# Function to find and list commands for a package
find_package_commands() {
    local pkg_path="$1"
    local package_name="$2"
    
    if [ ! -d "$pkg_path/bin" ]; then
        return
    fi
    
    # Get all commands, sorted alphabetically (like ls does)
    local all_commands=$(ls "$pkg_path/bin" 2>/dev/null | sort)
    
    if [ -n "$all_commands" ]; then
        local commands=$(echo "$all_commands" | tr '\n' ',' | sed 's/,/, /g' | sed 's/, $//')
        echo "  Commands: $commands"
    fi
}

# Function to display package info based on flags
display_package_info() {
    local package_name="$1"
    local version="$2"
    local description="$3"
    local pkg_path="$4"
    
    # Build the main line
    local main_line="• $package_name$version"
    
    echo "$main_line"
    
    # Show description if requested
    if [[ "$DESCRIPTIONS" == "true" ]]; then
        echo "  Description: $description"
    fi
    
    # Show commands if requested
    if [[ "$COMMANDS" == "true" ]]; then
        find_package_commands "$pkg_path" "$package_name"
    fi
}

# Parse flags
COMMANDS=false
DESCRIPTIONS=false

for arg in "$@"; do
  case $arg in
    --commands|-c)
      COMMANDS=true
      ;;
    --descriptions|-d)
      DESCRIPTIONS=true
      ;;
  esac
done

# Determine title based on flags
if [[ "$COMMANDS" == "true" && "$DESCRIPTIONS" == "true" ]]; then
  echo "📦 Full package info in $ENVIRONMENT_NAME:"
elif [[ "$COMMANDS" == "true" ]]; then
  echo "📦 Detailed packages in $ENVIRONMENT_NAME:"
elif [[ "$DESCRIPTIONS" == "true" ]]; then
  echo "📦 Package descriptions in $ENVIRONMENT_NAME:"
else
  echo "📦 Declared packages in $ENVIRONMENT_NAME:"
fi
echo "================================================="

# Process each package (package info will be injected by Nix)
PACKAGE_INFO_PLACEHOLDER

echo
echo "💡 Use 'list-packages -c' for commands, '-d' for descriptions, '-c -d' for both"
echo "💡 Use 'package-info <name>' for detailed package information"
echo "💡 Use 'which <command>' to see the full path of a specific command"
