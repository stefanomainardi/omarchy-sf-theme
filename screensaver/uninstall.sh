#!/bin/bash

# Spark-Omarchy Screensaver Uninstallation Script
# Restores the original Omarchy screensaver system

set -e

HYPRIDLE_CONFIG="$HOME/.config/hypr/hypridle.conf"
BACKUP_SUFFIX=".spark-screensaver-backup"
SCREENSAVER_MODE_FILE="$HOME/.config/screensaver-mode"

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

print_status "Uninstalling Spark-Omarchy Smart Screensaver..."

# Check if backup exists
if [[ ! -f "${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}" ]]; then
    print_error "Backup file not found: ${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}"
    print_error "Cannot safely restore original configuration"
    exit 1
fi

# Restore original hypridle config
print_status "Restoring original hypridle configuration..."
mv "${HYPRIDLE_CONFIG}${BACKUP_SUFFIX}" "$HYPRIDLE_CONFIG"
print_success "Original hypridle.conf restored"

# Remove screensaver mode file
if [[ -f "$SCREENSAVER_MODE_FILE" ]]; then
    print_status "Removing screensaver mode file..."
    rm "$SCREENSAVER_MODE_FILE"
    print_success "Screensaver mode file removed"
fi

# Kill any running screensavers
if pgrep -f "alacritty --class Screensaver" >/dev/null; then
    print_status "Stopping active screensavers..."
    pkill -f "alacritty --class Screensaver" 2>/dev/null || true
fi

print_success "Smart screensaver system uninstalled!"
echo ""
echo -e "${BLUE}Info:${NC} The screensaver scripts remain in the theme directory"
echo "      You can reinstall anytime by running install.sh"
echo ""
echo -e "${GREEN}System restored to original Omarchy screensaver${NC}"