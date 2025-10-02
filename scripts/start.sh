#!/usr/bin/env bash
set -eo pipefail

export DISPLAY=:0
export QT_X11_NO_MITSHM=1
export LIBGL_ALWAYS_SOFTWARE=1
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

# Virtual X screen
Xvfb :0 -screen 0 1280x800x24 &

# Window manager (may remove?)
fluxbox &

# Spin up VNC to capture display and forward to cweb VNC on :6080
x11vnc -display :0 -nopw -forever -shared -rfbport 5900 -quiet &
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &
# Start rviz2
source /opt/ros/humble/setup.bash
exec rviz2
