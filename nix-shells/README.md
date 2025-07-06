# Nix Development Shells

A collection of Nix development environments with a shared library for common functionality.

## Features

- 🚀 **Quick Environment Setup**: Pre-configured development environments for different languages and tools
- 📦 **Smart Package Listing**: Built-in `list-packages` command with multiple display modes
- 🔧 **Extensible**: Easy to create new environments using the provided template
- 📝 **Consistent Interface**: All environments share the same base functionality
- 🎯 **Dynamic Command Detection**: Automatically discovers and prioritizes package executables
- 📋 **Rich Information**: Shows original names, Nix names, versions, descriptions, and commands

### Available Environments

### C Development (`c-development.nix`)

- **GCC**: GNU Compiler Collection
- **GMP**: GNU Multiple Precision Arithmetic Library
- **CMake**: Cross-platform build system

### Node.js Development

- **Node.js 20** (`node20-development.nix`)
- **Node.js 22** (`node22-development.nix`)
- **Node.js 24** (`node24-development.nix`)

Each Node.js environment includes:

- **Yarn**: Package manager
- **PNPM**: Fast, disk space efficient package manager
- **TypeScript**: Typed superset of JavaScript

## Quick Start

### Enter an Environment

```bash
# Enter C development environment
nix-shell c-development.nix

# Enter Node.js 20 environment
nix-shell node20-development.nix
```

### List Declared Packages

Once in any environment, use the built-in command:

```bash
# Show original package names (default)
list-packages

# Show available commands for each package
list-packages -c
list-packages --commands

# Show package descriptions
list-packages -d
list-packages --descriptions
```

**Default output:**

```
📦 Declared packages in C Development:
=================================================
• gcc-wrapper (14.2.1.20250322)
• gmp-with-cxx (6.3.0)
• cmake (3.31.6)

💡 Use 'list-packages -c' for commands, '-d' for descriptions, '-c -d' for both
💡 Use 'which <command>' to see the full path of a specific command
```

**Commands output (`-c`):**

```
📦 Detailed packages in C Development:
=================================================
• gcc-wrapper (14.2.1.20250322)
  Commands: addr2line, ar, as, c++, cc
• gmp-with-cxx (6.3.0)
• cmake (3.31.6)
  Commands: cmake, cpack, ctest

💡 Use 'list-packages -c' for commands, '-d' for descriptions, '-c -d' for both
💡 Use 'which <command>' to see the full path of a specific command
```

**Descriptions output (`-d`):**

```
📦 Package descriptions in C Development:
=================================================
• gcc-wrapper (14.2.1.20250322)
  Description: GNU Compiler Collection, version 14.2.1
• gmp-with-cxx (6.3.0)
  Description: GNU Multiple Precision Arithmetic Library
• cmake (3.31.6)
  Description: Cross-platform, open-source build system

💡 Use 'list-packages -c' for commands, '-d' for descriptions, '-c -d' for both
💡 Use 'which <command>' to see the full path of a specific command
```

## Creating New Environments

Use the provided template to create new development environments:

1. **Copy the template:**

   ```bash
   cp template.nix my-new-environment.nix
   ```

2. **Edit the new file:**

   ```nix
    { pkgs ? import <nixpkgs> { } }:

    let
      envBuildInputs = with pkgs; [
        # package names
      ];
      lib = import ./lib/default.nix {
        name = "Template";
        inherit pkgs;
        buildInputs = envBuildInputs;
      };
    in
    pkgs.mkShell {
      inherit (lib) shellHook;

      # Define the build inputs for the environment
      buildInputs = envBuildInputs ++ lib.buildInputs;
    }
   ```

3. **Enter your new environment:**
   ```bash
   nix-shell my-new-environment.nix
   ```

## Project Structure

```
nix-shells/
├── README.md                 # This file
├── template.nix             # Template for new environments
├── c-development.nix        # C development environment
├── node20-development.nix   # Node.js 20 environment
├── node22-development.nix   # Node.js 22 environment
├── node24-development.nix   # Node.js 24 environment
└── lib/
    ├── default.nix          # Shared library with common functionality
    ├── list-packages.sh     # Main script logic for package listing
    └── node-packages.nix    # Common Node.js packages
```

## Library Components

### `lib/default.nix`

Provides shared functionality for all environments:

- **shellHook**: Welcome message and setup
- **Package processing**: Uses actual nixpkgs package names (`pname` or `name`)
- **Script generation**: Creates the list-packages command with injected package data
- **buildInputs**: Includes the generated list-packages script

The library accepts an array of package derivations in `buildInputs` and uses their authentic nixpkgs names without modification.

### `lib/list-packages.sh`

Main script containing all the package listing logic:

- **Flag parsing**: Handles `-c` (commands) and `-d` (descriptions) flags
- **Command detection**: Dynamically finds and prioritizes executable commands
- **Display logic**: Shows package information based on selected flags
- **Template system**: Uses placeholders for Nix-generated package data

### `lib/node-packages.nix`

Common Node.js packages shared across all Node.js environments:

- Yarn
- PNPM
- TypeScript

## Tips & Tricks

### Check Package Paths

```bash
which gcc  # Shows full Nix store path
```

### Explore Dependencies

```bash
nix-store -q --tree $NIX_STORE_PATH
```

### Update Packages

```bash
# Update nixpkgs channel
nix-channel --update

# Enter environment with latest packages
nix-shell c-development.nix
```

### Using with direnv (Optional)

Create a `.envrc` file in your project:

```bash
#!/usr/bin/env bash
use nix /path/to/nix-shells/node20-development.nix
```

Then run:

```bash
direnv allow
```

This will automatically enter the Nix environment when you `cd` into the directory.

## Customization

### Adding Global Packages

Edit `lib/default.nix` to add packages available in all environments.

### Environment-Specific Packages

Edit the individual environment files (e.g., `c-development.nix`) to add packages specific to that environment.

### Custom Shell Hook

Modify the `shellHook` in `lib/default.nix` to customize the startup behavior for all environments.

## Troubleshooting

### Command Not Found

If `list-packages` shows a package but the command isn't found:

1. Check if the package provides the expected executable name
2. Use `which <command>` to verify the path
3. Some packages may install executables with different names

### Package Names Look Different

The `list-packages` command shows authentic nixpkgs package names by default:

- **`gcc`** appears as **`gcc-wrapper`** (includes wrapper scripts and additional tools)
- **`gmp`** appears as **`gmp-with-cxx`** (includes C++ support)
- This is normal Nix behavior where packages are wrapped or enhanced with additional functionality

Use flags for more info:

- **`-c`**: Shows available commands for each package
- **`-d`**: Shows official package descriptions from nixpkgs

### Environment Not Loading

1. Ensure you're using `nix-shell` command correctly
2. Check that all required files exist in the `lib/` directory
3. Verify Nix syntax with `nix-instantiate --parse <file>.nix`

### Package Version Issues

1. Update your nixpkgs channel: `nix-channel --update`
2. Use `nix search <package>` to find available packages
3. Pin specific versions if needed using nixpkgs commits
