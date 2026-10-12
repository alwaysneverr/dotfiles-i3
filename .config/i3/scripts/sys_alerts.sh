#!/usr/bin/env bash

while true; do
    # --- 1. Disk Space Monitoring (Triggers warning if Root Partition / is > 85% full) ---
    disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$disk_usage" -gt 85 ]; then
        notify-send "⚠️ Critical Storage Space" \
                    "Root partition usage is high at ${disk_usage}%!\nConsider clearing pacman caches or logs." \
                    -u critical
    fi

    # --- 2. Broken Systemd Services Audit ---
    failed_services=$(systemctl --failed --property=Id | grep ".service" | awk -F= '{print $2}')
    if [ -n "$failed_services" ]; then
        notify-send "⚙️ Failed System Services Detected" \
                    "The following background system units broke:\n$failed_services" \
                    -u normal
    fi

    # --- 3. Orphaned Package Audit (Arch Linux maintenance) ---
    orphans=$(pacman -Qdtq)
    if [ -n "$orphans" ]; then
        orphan_count=$(echo "$orphans" | wc -l)
        notify-send "📦 System Maintenance Alert" \
                    "You have $orphan_count isolated orphan packages consuming disk space. Run 'sudo pacman -Rns \$(pacman -Qdtq)' to purge." \
                    -u low
    fi

    # Sleep loop for 10 minutes before polling metrics again
    sleep 600
done
