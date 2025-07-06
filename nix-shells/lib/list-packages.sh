#!/bin/bash

# Function to find and prioritize commands for a package
find_package_commands() {
    local pkg_path="$1"
    local original_name="$2"
    
    if [ ! -d "$pkg_path/bin" ]; then
        return
    fi
    
    # Get all commands and prioritize the main one
    local all_commands=$(ls "$pkg_path/bin" 2>/dev/null | sort)
    local main_command=""
    local other_commands=""
    
    # Check if the original name exists as a command
    if echo "$all_commands" | grep -q "^$original_name$"; then
        main_command="$original_name"
        other_commands=$(echo "$all_commands" | grep -v "^$original_name$" | head -4)
    else
        # If not, just take first 5
        other_commands=$(echo "$all_commands" | head -5)
    fi
    
    # Combine and format
    local commands=""
    if [ -n "$main_command" ]; then
        if [ -n "$other_commands" ]; then
            commands="$main_command, $(echo "$other_commands" | tr '\n' ',' | sed 's/,/, /g' | sed 's/, $//')"
        else
            commands="$main_command"
        fi
    else
        commands=$(echo "$other_commands" | tr '\n' ',' | sed 's/,/, /g' | sed 's/, $//')
    fi
    
    if [ -n "$commands" ]; then
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
echo "💡 Use 'which <command>' to see the full path of a specific command"
