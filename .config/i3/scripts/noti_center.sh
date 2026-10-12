#!/usr/bin/env bash

# Fetch notification history using dunstctl in JSON format
history_raw=$(dunstctl history)

# Parse history into lines: "ID[#] ▪ Title — Body"
mapfile -t lines < <(echo "$history_raw" | grep -E '"(id|summary|body)"' | awk -F'"' '{print $4}' | paste - - - | awk -F'\t' '{print "ID["$1"] ▪ "$2" — "$3}')

# If no notifications found, tell the user gracefully via rofi
if [ ${#lines[@]} -eq 0 ]; then
    echo "No notification history available." | rofi -dmenu -p " 🔔 Alerts "
    exit 0
fi

# Present history to user via rofi using your central theme rules
selected=$(printf '%s\n' "${lines[@]}" | rofi -dmenu -i -p " 🔔 History ")

# Extract the target ID and redisplay it if selected
if [[ "$selected" =~ ID\[([0-9]+)\] ]]; then
    noti_id="${BASH_REMATCH[1]}"
    dunstctl history-pop "$noti_id"
fi
