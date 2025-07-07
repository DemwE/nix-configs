#!/bin/bash

echo "🛠️ Available Commands in $ENVIRONMENT_NAME"
echo "============================================="
echo "📦 Package Management:"
echo "  list-packages              List all packages in environment"
echo "  list-packages -c           Show available commands for each package"
echo "  list-packages -d           Show package descriptions"
echo "  list-packages -s           Show package sizes"
echo "  package-info <name>        Detailed information about specific package"
echo
echo "🏗️ Environment Information:"
echo "  env-info                   Show environment summary (name, package count, total size)"
echo "  help                       Show this help message"
echo
echo "💡 Tips:"
echo "  • Use 'which <command>' to see full path of any command"
echo "  • Combine flags: 'list-packages -c -s' for commands and sizes"
echo "  • Package names use authentic nixpkgs names (e.g., gcc-wrapper)"
