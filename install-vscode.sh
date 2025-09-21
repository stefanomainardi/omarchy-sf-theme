#!/bin/bash

# Spark Omarchy VSCode Extension Installer
# This script installs the Spark Omarchy theme as a VSCode extension

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSION_DIR="$HOME/.vscode/extensions"
EXTENSION_NAME="stefano-mainardi.spark-omarchy-theme-1.0.0"
EXTENSION_PATH="$EXTENSION_DIR/$EXTENSION_NAME"

echo "🚀 Installing Spark Omarchy VSCode Theme..."

# Check if VSCode is installed
if ! command -v code &> /dev/null; then
    echo "❌ VSCode not found. Please install VSCode first."
    exit 1
fi

# Create extensions directory if it doesn't exist
mkdir -p "$EXTENSION_DIR"

# Remove existing extension if present
if [ -d "$EXTENSION_PATH" ]; then
    echo "🔄 Removing existing extension..."
    rm -rf "$EXTENSION_PATH"
fi

# Copy extension files
echo "📦 Installing extension..."
cp -r "$SCRIPT_DIR/vscode-extension" "$EXTENSION_PATH"

# Verify installation
if [ -d "$EXTENSION_PATH" ]; then
    echo "✅ Spark Omarchy theme installed successfully!"
    echo "📖 Open VSCode and go to: Preferences → Color Theme → Spark Omarchy"
    echo ""
    echo "🔧 To auto-apply with Omarchy theme system:"
    echo "   omarchy-theme-set spark-omarchy"
else
    echo "❌ Installation failed!"
    exit 1
fi