# Nix Development Shells

A collection of Nix development environments with a shared library for common functionality.

## Features

- 🚀 **Quick Environment Setup**: Pre-configured development environments
- 📦 **Smart Package Listing**: Built-in `list-packages` and `package-info` commands
- 🔧 **Extensible**: Easy to create new environments using the provided template
- 📝 **Consistent Interface**: All environments share the same base functionality

## Available Environments

- **C Development** (`c-development.nix`)
- **Node.js Development** (`node20-development.nix`, `node22-development.nix`, `node24-development.nix`)

## Quick Start

### Enter an Environment

```bash
nix-shell <enviroment-name>.nix
```

### Available Commands

```bash
# List all packages
list-packages

# Show commands for each package
list-packages -c

# Show package descriptions
list-packages -d

# Show package sizes
list-packages -s

# Detailed info about specific package
package-info <full-package-name>

# Environment summary
env-info
```

### Example Output

**Basic listing:**

```
📦 Declared packages in C Development:
• gcc-wrapper (14.2.1.20250322)
• cmake (3.31.6)
```

**With commands (`-c`):**

```
📦 Detailed packages in C Development:
• gcc-wrapper (14.2.1.20250322)
  Commands: gcc, g++, ar, as, ld
• cmake (3.31.6)
  Commands: cmake, cpack, ctest
```

**With sizes (`-s`):**

```
📦 Package sizes in C Development:
• gcc-wrapper (14.2.1.20250322) [245 MB]
• cmake (3.31.6) [89 MB]
=================================================
Total Size: 334 MB
```

**Package details (`package-info gcc-wrapper`):**

```
� Package Information
Name: gcc-wrapper
Version: 14.2.1.20250322
Store Path: /nix/store/abc123-gcc-wrapper/

� Available Commands:
  • gcc
  • g++
  • ar

🔗 Dependencies:
  • glibc
  • binutils-wrapper
```

**Environment summary (`env-info`):**

```
🏗️ Environment Information
==========================
Name: C Development
Packages: 3
Total Size: 425 MB
```

## Creating New Environments

```bash
# Copy template
cp template.nix my-environment.nix

# Edit and add your packages
# Enter your environment
nix-shell my-environment.nix
```

````

## Tips & Tricks

```bash
# Check command location
which gcc

# Explore dependencies
nix-store -q --tree $NIX_STORE_PATH

# Update packages
nix-channel --update
````

## Common Issues

**Command not found**: Use `list-packages -c` to see available commands

**Package names**: Nix shows authentic package names (e.g., `gcc-wrapper` instead of `gcc`)

**Environment issues**: Verify files exist in `lib/` directory and use `nix-instantiate --parse <file>.nix`
