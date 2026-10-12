#!/usr/bin/env bash

# Ensure directory structure exists
TARGET_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$TARGET_DIR"

# Construct a timestamped file destination
FILE_PATH="$TARGET_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Check mode parameter passed from i3 keybinding
if [ "$1" = "select" ]; then
    # Interactive crop region selection (-s allows drawing a selection box)
    maim -s "$FILE_PATH"
else
    # Full monitor capture
    maim "$FILE_PATH"
fi

# Confirm execution status
if [ -f "$FILE_PATH" ]; then
    # Pipeline file contents straight into X11 system selection clipboard
    xclip -selection clipboard -t image/png < "$FILE_PATH"
    
    # Fire the Dunst alert showing a live thumbnail preview (-i passes the preview icon path)
    dunstify -a "maim" -i "$FILE_PATH" "Screenshot Captured" "Saved to: $(basename "$FILE_PATH")\nCopied to clipboard." | xargs -I {} sh -c 'if [ "{}" = "open_folder" ]; then xdg-open ~/Pictures/Screenshots; fi'
else
    dunstify -a "maim" -u "low" "Screenshot Canceled" "No capture area was saved."
fi
