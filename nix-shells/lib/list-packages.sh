#!/bin/bash

# Function to get package size in human readable format
get_package_size() {
    local pkg_path="$1"
    
    if [ ! -d "$pkg_path" ]; then
        echo "unknown"
        return
    fi
    
    local size_bytes=$(du -sb "$pkg_path" 2>/dev/null | cut -f1)
    
    if [ -z "$size_bytes" ] || [ "$size_bytes" = "0" ]; then
        echo "unknown"
        return
    fi
    
    # Convert to human readable format
    if [ $size_bytes -gt 1073741824 ]; then
        echo "$(( size_bytes / 1073741824 )) GB"
    elif [ $size_bytes -gt 1048576 ]; then
        echo "$(( size_bytes / 1048576 )) MB"
    elif [ $size_bytes -gt 1024 ]; then
        echo "$(( size_bytes / 1024 )) KB"
    else
        echo "${size_bytes} B"
    fi
}

# Function to calculate total size of all packages
calculate_total_size() {
    local total_bytes=0
    
    # This will be replaced by Nix with package paths for total calculation
    TOTAL_SIZE_CALCULATION_PLACEHOLDER
    
    # Convert to human readable format
    if [ $total_bytes -gt 1073741824 ]; then
        echo "$(( total_bytes / 1073741824 )) GB"
    elif [ $total_bytes -gt 1048576 ]; then
        echo "$(( total_bytes / 1048576 )) MB"
    elif [ $total_bytes -gt 1024 ]; then
        echo "$(( total_bytes / 1024 )) KB"
    else
        echo "${total_bytes} B"
    fi
}
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
    
    # Add size if requested
    if [[ "$SIZES" == "true" ]]; then
        local size=$(get_package_size "$pkg_path")
        main_line="$main_line [$size]"
    fi
    
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
SIZES=false

for arg in "$@"; do
  case $arg in
    --commands|-c)
      COMMANDS=true
      ;;
    --descriptions|-d)
      DESCRIPTIONS=true
      ;;
    --sizes|-s)
      SIZES=true
      ;;
  esac
done

# Determine title based on flags
if [[ "$COMMANDS" == "true" && "$DESCRIPTIONS" == "true" && "$SIZES" == "true" ]]; then
  echo "📦 Complete package info in $ENVIRONMENT_NAME:"
elif [[ "$COMMANDS" == "true" && "$DESCRIPTIONS" == "true" ]]; then
  echo "📦 Full package info in $ENVIRONMENT_NAME:"
elif [[ "$COMMANDS" == "true" && "$SIZES" == "true" ]]; then
  echo "📦 Detailed packages with sizes in $ENVIRONMENT_NAME:"
elif [[ "$DESCRIPTIONS" == "true" && "$SIZES" == "true" ]]; then
  echo "📦 Package descriptions with sizes in $ENVIRONMENT_NAME:"
elif [[ "$COMMANDS" == "true" ]]; then
  echo "📦 Detailed packages in $ENVIRONMENT_NAME:"
elif [[ "$DESCRIPTIONS" == "true" ]]; then
  echo "📦 Package descriptions in $ENVIRONMENT_NAME:"
elif [[ "$SIZES" == "true" ]]; then
  echo "📦 Package sizes in $ENVIRONMENT_NAME:"
else
  echo "📦 Declared packages in $ENVIRONMENT_NAME:"
fi
echo "================================================="

# Process each package (package info will be injected by Nix)
PACKAGE_INFO_PLACEHOLDER

# Show total size if sizes were requested
if [[ "$SIZES" == "true" ]]; then
    echo "================================================="
    total_size=$(calculate_total_size)
    echo "Total Size: $total_size"
fi

echo
echo "💡 Use 'list-packages -c' for commands, '-d' for descriptions, '-s' for sizes"
echo "💡 Use 'package-info <name>' for detailed package information"
echo "💡 Use 'which <command>' to see the full path of a specific command"
