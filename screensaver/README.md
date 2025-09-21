# Spark-Omarchy Smart Screensaver System

This directory contains a smart screensaver system that allows you to toggle between the default Omarchy logo and a custom Spark logo for your screensaver animations.

## 🎯 Features

- **Smart Toggle**: Switch between Omarchy and Spark logos instantly
- **Non-Invasive**: Only modifies one line in `hypridle.conf`
- **Safe Installation**: Creates backups and easy uninstall
- **Notifications**: Desktop notifications when switching modes
- **Self-Contained**: Everything stays within the theme directory

## 📁 Files

```
screensaver/
├── screensaver.txt              # Custom Spark logo (ASCII art)
├── smart-screensaver-launcher   # Intelligent launcher script
├── spark-screensaver-cmd        # Screensaver command for Spark logo
├── toggle-screensaver-logo      # Toggle between logos
├── install.sh                   # Installation script
├── uninstall.sh                 # Uninstallation script
└── README.md                    # This documentation
```

## 🚀 Installation

1. **Install the system:**
   ```bash
   ~/.local/share/omarchy/themes/spark-omarchy/screensaver/install.sh
   ```

2. **Restart hypridle to apply changes:**
   ```bash
   pkill hypridle && hypridle &
   ```

3. **Optional - Create a convenient alias:**
   Add to your `~/.bashrc` or `~/.zshrc`:
   ```bash
   alias toggle-screensaver='~/.local/share/omarchy/themes/spark-omarchy/screensaver/toggle-screensaver-logo'
   ```

## 🚨 Important Usage Notes

### ✅ Smart Screensaver Works With:
- **Automatic timeout** (2.5 minutes of inactivity) - Uses your selected logo
- **Hypridle triggers** - Respects your toggle settings
- **Manual smart launcher** - `smart-screensaver-launcher force`

### ⚠️ Smart Screensaver Does NOT Work With:
- **Omarchy Menu** → System → Screensaver (always shows Omarchy logo)
- This is intentional to keep the system non-invasive and preserve original Omarchy behavior

## 🎮 Usage

### How to Use Your Custom Logo:
1. **Set your preferred logo:**
   ```bash
   ~/.local/share/omarchy/themes/spark-omarchy/screensaver/toggle-screensaver-logo spark
   ```

2. **Let it activate automatically:** Wait for 2.5 minutes of inactivity ✅

3. **OR trigger manually:**
   ```bash
   ~/.local/share/omarchy/themes/spark-omarchy/screensaver/smart-screensaver-launcher force
   ```

### Basic Commands
```bash
# Toggle between Omarchy and Spark logos
~/.local/share/omarchy/themes/spark-omarchy/screensaver/toggle-screensaver-logo

# Or with alias (if created):
toggle-screensaver
```

### Specific Mode Commands
```bash
# Set to Spark logo
toggle-screensaver spark

# Set to Omarchy logo
toggle-screensaver omarchy

# Check current mode
toggle-screensaver status

# Show help
toggle-screensaver help
```

### Quick Access Tip
Create a convenient alias for easy access:
```bash
# Add to your ~/.bashrc or ~/.zshrc
alias toggle-screensaver='~/.local/share/omarchy/themes/spark-omarchy/screensaver/toggle-screensaver-logo'
alias force-screensaver='~/.local/share/omarchy/themes/spark-omarchy/screensaver/smart-screensaver-launcher force'
```

## ⚙️ How It Works

### System Architecture
1. **`hypridle.conf`** calls `smart-screensaver-launcher` instead of `omarchy-launch-screensaver`
2. **`smart-screensaver-launcher`** reads `~/.config/screensaver-mode` to decide which logo to use
3. **`toggle-screensaver-logo`** changes the mode file and shows notifications

### Mode Storage
The current mode is stored in `~/.config/screensaver-mode`:
- `omarchy` = Use default Omarchy logo
- `spark` = Use custom Spark logo

### Integration with Omarchy
- Preserves all Omarchy screensaver functionality
- Uses same timing, effects, and terminal setup
- Only changes the logo file used by `tte` (terminal text effects)

## 🔧 Technical Details

### Modified Configuration
The installation script changes one line in `~/.config/hypr/hypridle.conf`:

**Before:**
```
on-timeout = pidof hyprlock || omarchy-launch-screensaver
```

**After:**
```
on-timeout = pidof hyprlock || ~/.local/share/omarchy/themes/spark-omarchy/screensaver/smart-screensaver-launcher
```

### Dependencies
- `tte` (terminal text effects) - for animations
- `jq` - for JSON parsing
- `alacritty` - terminal emulator
- `hyprctl` - Hyprland control
- `notify-send` (optional) - for desktop notifications

### Effects Support
All `tte` effects work with the custom logo:
- beams, matrix, slide, wipe, decrypt, etc.
- Random effect selection on each screensaver activation

## 🛡️ Safety & Backup

### What Gets Backed Up
- `~/.config/hypr/hypridle.conf` → `~/.config/hypr/hypridle.conf.spark-screensaver-backup`

### Uninstall Process
```bash
~/.local/share/omarchy/themes/spark-omarchy/screensaver/uninstall.sh
```

This will:
1. Restore the original `hypridle.conf` from backup
2. Remove `~/.config/screensaver-mode` file
3. Stop any active screensavers
4. Leave theme files intact for future use

## 🎨 Customizing the Logo

To change the Spark logo:

1. **Edit the ASCII art:**
   ```bash
   nano ~/.local/share/omarchy/themes/spark-omarchy/screensaver/screensaver.txt
   ```

2. **Test the logo:**
   ```bash
   # Switch to spark mode
   toggle-screensaver spark

   # Trigger screensaver manually (wait for idle timeout or force)
   ~/.local/share/omarchy/themes/spark-omarchy/screensaver/smart-screensaver-launcher force
   ```

### ASCII Art Tips
- Keep reasonable dimensions (fits in terminal)
- Use Unicode characters for better visual effects
- Test with different `tte` effects
- Consider line length and height

## 🐛 Troubleshooting

### Screensaver not switching logos
```bash
# Check current mode
toggle-screensaver status

# Verify mode file exists
cat ~/.config/screensaver-mode

# Check if smart launcher is being called
grep smart-screensaver-launcher ~/.config/hypr/hypridle.conf
```

### Logo not displaying correctly
```bash
# Test the logo directly with tte
tte -i ~/.local/share/omarchy/themes/spark-omarchy/screensaver/screensaver.txt beams
```

### Restore original system
```bash
# Run uninstall script
~/.local/share/omarchy/themes/spark-omarchy/screensaver/uninstall.sh

# Or manually restore
cp ~/.config/hypr/hypridle.conf.spark-screensaver-backup ~/.config/hypr/hypridle.conf
```

## 📄 License

This screensaver system is part of the Spark-Omarchy theme and follows the same license terms.

---

*Part of the Spark-Omarchy theme - A vibrant take on the Omarchy Linux experience*