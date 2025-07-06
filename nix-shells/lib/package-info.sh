#!/bin/bash

# Function to display detailed package information
show_package_info() {
    local package_name="$1"
    local version="$2"
    local description="$3"
    local pkg_path="$4"
    
    echo "📋 Package Information"
    echo "======================"
    echo "Name: $package_name"
    echo "Version: $version"
    echo "Description: $description"
    echo "Store Path: $pkg_path"
    echo
    
    # Show available commands
    if [ -d "$pkg_path/bin" ]; then
        echo "📟 Available Commands:"
        echo "---------------------"
        local commands=$(ls "$pkg_path/bin" 2>/dev/null | sort)
        if [ -n "$commands" ]; then
            echo "$commands" | while read cmd; do
                echo "  • $cmd"
            done
        else
            echo "  No commands available"
        fi
        echo
    fi
    
    # Show package size
    if [ -d "$pkg_path" ]; then
        echo "💾 Package Size:"
        echo "---------------"
        local size=$(du -sh "$pkg_path" 2>/dev/null | cut -f1)
        if [ -n "$size" ]; then
            echo "  $size"
        else
            echo "  Size unavailable"
        fi
        echo
    fi
    
    # Show main directories
    echo "📁 Package Structure:"
    echo "--------------------"
    if [ -d "$pkg_path" ]; then
        ls -la "$pkg_path" 2>/dev/null | grep "^d" | awk '{print "  • " $9}' | grep -v "^\s*• \.$" | grep -v "^\s*• \.\.$"
    fi
    echo
    
    # Show dependencies
    echo "🔗 Dependencies:"
    echo "---------------"
    if [ -d "$pkg_path" ]; then
        # Get dependencies from nix-store
        local deps=$(nix-store -q --references "$pkg_path" 2>/dev/null | grep -v "^$pkg_path$" | sort)
        if [ -n "$deps" ]; then
            echo "$deps" | while read dep; do
                local dep_name=$(basename "$dep" | sed 's/^[a-z0-9]*-//')
                echo "  • $dep_name"
                echo "    $dep"
            done | head -20
            
            local dep_count=$(echo "$deps" | wc -l)
            if [ "$dep_count" -gt 10 ]; then
                echo "  ... and $(($dep_count - 10)) more dependencies"
            fi
        else
            echo "  No dependencies or unable to determine"
        fi
    fi
    echo
    
    # Show license info if available
    if [ -f "$pkg_path/share/doc/*/LICENSE" ] || [ -f "$pkg_path/LICENSE" ]; then
        echo "📄 License Information:"
        echo "----------------------"
        local license_file=""
        if [ -f "$pkg_path/LICENSE" ]; then
            license_file="$pkg_path/LICENSE"
        else
            license_file=$(find "$pkg_path/share/doc" -name "LICENSE" -o -name "COPYING" 2>/dev/null | head -1)
        fi
        
        if [ -n "$license_file" ] && [ -f "$license_file" ]; then
            head -10 "$license_file" | sed 's/^/  /'
            if [ $(wc -l < "$license_file") -gt 10 ]; then
                echo "  ... (truncated, see full license at: $license_file)"
            fi
        fi
        echo
    fi
    
    # Show man pages if available
    if [ -d "$pkg_path/share/man" ]; then
        echo "📖 Manual Pages:"
        echo "---------------"
        find "$pkg_path/share/man" -name "*.gz" 2>/dev/null | while read manpage; do
            local basename=$(basename "$manpage" .gz)
            local section=$(echo "$basename" | sed 's/.*\.\([0-9]\)$/\1/')
            local name=$(echo "$basename" | sed 's/\.[0-9]$//')
            echo "  • $name($section)"
        done | sort | head -10
        echo
    fi
}

# Parse command line arguments
if [ $# -eq 0 ]; then
    echo "Usage: package-info <package-name>"
    echo "Shows detailed information about a specific package in the current environment."
    echo
    echo "Example: package-info gcc-wrapper"
    exit 1
fi

SEARCH_PACKAGE="$1"

# This placeholder will be replaced by Nix with the actual package data
# Format: package_name|version|description|pkg_path
PACKAGE_DATA_PLACEHOLDER

# If we reach here, package was not found
echo "❌ Package '$SEARCH_PACKAGE' not found in current environment."
echo
echo "Available packages:"
echo "AVAILABLE_PACKAGES_PLACEHOLDER"
