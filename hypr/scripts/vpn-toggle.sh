#!/usr/bin/env bash
set -euo pipefail

# --- Configuration ---
GATEWAY="vpn.it.unideb.hu"
USERNAME="martinsandor707"
AUTHGROUP="Access_internal_systems"
CRED_FILE="$HOME/.config/vpn/uni-pass.cred"
PID_FILE="/run/openconnect-uni.pid"
APP_NAME="University VPN"

# Ensure notify-send is present in environment
notify() {
  local urgency="$1"
  local title="$2"
  local msg="$3"
  local icon="$4"
  notify-send -a "$APP_NAME" -u "$urgency" -i "$icon" "$title" "$msg"
}

is_vpn_running() {
  if [[ -f "$PID_FILE" ]]; then
    local pid
    pid="$(cat "$PID_FILE" 2>/dev/null || true)"
    if [[ -n "$pid" && -d "/proc/$pid" ]]; then
      return 0
    fi
  fi
  return 1
}

# 1. Disconnect if tunnel is active
if is_vpn_running; then
  VPN_PID="$(cat "$PID_FILE")"
  
  # SIGINT prompts OpenConnect to clean up routes and /etc/resolv.conf
  sudo /usr/bin/kill -SIGINT "$VPN_PID"
  
  TIMEOUT=5
  while [[ -d "/proc/$VPN_PID" ]] && (( TIMEOUT > 0 )); do
    sleep 1
    (( TIMEOUT-- ))
  done
  
  if [[ -d "/proc/$VPN_PID" ]]; then
    sudo /usr/bin/kill -SIGKILL "$VPN_PID"
  fi
  
  sudo /usr/bin/rm -f "$PID_FILE"
  notify "normal" "VPN Disconnected" "Tunnel closed; routes and DNS restored." "network-vpn-disconnected"
  exit 0
fi

# 2. Pre-flight verification
if [[ ! -f "$CRED_FILE" ]]; then
  notify "critical" "VPN Connection Error" "Missing credential file: $CRED_FILE" "dialog-error"
  exit 1
fi

notify "low" "VPN Connecting" "Establishing secure tunnel to $GATEWAY..." "network-vpn-acquiring"

# 3. Decrypt user-scoped credential and launch OpenConnect
if systemd-creds --user decrypt "$CRED_FILE" | sudo /usr/bin/openconnect "$GATEWAY" \
    --background \
    --pid-file="$PID_FILE" \
    --user="$USERNAME" \
    --authgroup="$AUTHGROUP" \
    --passwd-on-stdin; then

  # 4. Poll for daemonization and interface initialization (up to 8 seconds)
  CONNECTED=0
  for _ in {1..8}; do
    if is_vpn_running; then
      CONNECTED=1
      break
    fi
    sleep 1
  done

  if (( CONNECTED == 1 )); then
    notify "normal" "VPN Connected" "Secure tunnel active to $GATEWAY" "network-vpn"
  else
    notify "critical" "VPN Connection Failed" "Handshake timed out or daemon exited prematurely." "dialog-error"
    exit 1
  fi
else
  notify "critical" "VPN Connection Failed" "OpenConnect failed to initiate." "dialog-error"
  exit 1
fi