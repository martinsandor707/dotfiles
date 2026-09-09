#!/usr/bin/env bash
set -eo pipefail

# Restart user-level PipeWire daemons and the WirePlumber session manager
if systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service; then
    notify-send -u low -i audio-volume-high "Audio Stack" "PipeWire and WirePlumber successfully restarted."
else
    notify-send -u critical -i dialog-error "Audio Stack" "Failed to cycle audio services. Inspect journalctl --user."
    exit 1
fi