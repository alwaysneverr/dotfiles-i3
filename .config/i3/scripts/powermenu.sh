#!/usr/bin/env bash

# Modern, clean Unicode icons for the options
options="🔒\n🔄\n🛑\n🚪\n❌"

# Pass a custom theme adjustment directly to Rofi for a horizontal row layout
chosen=$(echo -e "$options" | rofi -dmenu -i -p " ⚡ System " -theme-str '
    window { width: 420px; }
    listview { columns: 5; lines: 1; fixed-height: true; cycle: true; }
    element { padding: 12px; text-align: center; }
    element-text { horizontal-align: 0.5; font: "JetBrains Mono 14"; }
')

case "$chosen" in
    "🔒")
        loginctl lock-session
        ;;
    "🔄")
        systemctl reboot
        ;;
    "🛑")
        systemctl poweroff
        ;;
    "🚪")
        i3-msg exit
        ;;
    *)
        exit 0
        ;;
esac
