#!/usr/bin/env bash

# Define the output directory and filename with a timestamp
OUT_DIR="$HOME/Videos"
OUT_FILE="$OUT_DIR/recording_$(date +"%Y-%m-%d_%H-%M-%S").mp4"

# Ensure the output directory exists
mkdir -p "$OUT_DIR"

# Check if wf-recorder is currently running
if pgrep -x "wf-recorder" >/dev/null; then
  # Process is running, send SIGINT for a clean exit
  pkill -INT -x wf-recorder
  notify-send "Recording Stopped" "File saved to $OUT_DIR" -u normal -t 3000
else
  # Process is not running.
  # Launch wf-recorder without the -g flag to capture the entire default display.
  notify-send "Recording Started" "Capturing entire screen..." -u low -t 2000
  wf-recorder -f "$OUT_FILE" &
fi
