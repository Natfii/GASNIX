#!/bin/sh
# Switch to a free virtual terminal (if ES runs on VT7, use VT8 for Weston)
chvt 8
# Start Weston with virtual keyboard in the background
weston --tty=8 --backend=drm-backend.so --modules=weston-keyboard &
sleep 2  # wait for compositor

# Export display environment for Wayland
export XDG_RUNTIME_DIR="/run/user/0"
export WAYLAND_DISPLAY=wayland-0

# Launch Chromium with touch/OSK flags
chromium --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3 "$@"

# Cleanup after Chromium exits
killall weston
chvt 7  # return to EmulationStation VT
