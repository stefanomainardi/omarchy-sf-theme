#!/bin/bash

# Spark-Omarchy Screensaver Installation Script
# Installs the smart screensaver system that can toggle between Omarchy and Spark logos

set -e

THEME_DIR="$HOME/.local/share/omarchy/themes/spark-omarchy"
HYPRIDLE_CONFIG="$HOME/.config/hypr/hypridle.conf"
BACKUP_SUFFIX=".spark-screensaver-backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [[ ! -f "$THEME_DIR/screensaver/smart-screensaver-launcher" ]]; then
    print_error "Spark-Omarchy theme not found or incomplete"
    print_error "Expected location: $THEME_DIR"
    exit 1
fi

# Check if hypridle config exists
if [[ ! -f "$HYPRIDLE_CONFIG" ]]; then
    print_error "Hypridle configuration not found: $HYPRIDLE_CONFIG"
    exit 1
fi

print_status "Installing Spark-Omarchy Smart Screensaver..."

# Create backup of hypridle config
print_status "Creating backup of hypridle.conf..."
cp "$HYPRIDLE_CONFIG" "${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}"
print_success "Backup created: ${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}"

# Modify hypridle.conf to use our smart launcher
print_status "Updating hypridle configuration..."
sed -i "s|omarchy-launch-screensaver|${THEME_DIR}/screensaver/smart-screensaver-launcher|g" "$HYPRIDLE_CONFIG"

# Verify the change was made
if grep -q "smart-screensaver-launcher" "$HYPRIDLE_CONFIG"; then
    print_success "Hypridle configuration updated successfully"
else
    print_error "Failed to update hypridle configuration"
    print_status "Restoring backup..."
    mv "${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}" "$HYPRIDLE_CONFIG"
    exit 1
fi

# Set initial mode to omarchy (preserve existing behavior)
echo "omarchy" > "$HOME/.config/screensaver-mode"

# Restart hypridle to apply changes
print_status "Restarting hypridle to apply changes..."
pkill hypridle 2>/dev/null || true
sleep 1
hypridle &
print_success "Hypridle restarted with new configuration"

print_success "Smart screensaver system installed!"
echo ""
echo -e "${BLUE}Usage:${NC}"
echo "  Toggle between logos:     $THEME_DIR/screensaver/toggle-screensaver-logo"
echo "  Set to Spark logo:        $THEME_DIR/screensaver/toggle-screensaver-logo spark"
echo "  Set to Omarchy logo:      $THEME_DIR/screensaver/toggle-screensaver-logo omarchy"
echo "  Check current mode:       $THEME_DIR/screensaver/toggle-screensaver-logo status"
echo ""
echo -e "${BLUE}Optional:${NC} Create a convenient alias by adding to your shell config:"
echo "  alias toggle-screensaver='$THEME_DIR/screensaver/toggle-screensaver-logo'"
echo ""
echo -e "${YELLOW}Note:${NC} To uninstall, run: $THEME_DIR/screensaver/uninstall.sh"