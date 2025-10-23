# start-vnc.sh
#!/usr/bin/env bash
set -eo pipefail
export DISPLAY=:0
export QT_X11_NO_MITSHM=1
export LIBGL_ALWAYS_SOFTWARE=1
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export XDG_RUNTIME_DIR=/tmp/runtime-root
mkdir -p "$XDG_RUNTIME_DIR" && chmod 0700 "$XDG_RUNTIME_DIR"

rm -f /tmp/.X0-lock /tmp/.X11-unix/X0 || true
mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix
pkill -f Xvfb || true
pkill -f x11vnc || true

Xvfb :0 -screen 0 1280x720x24 -ac &
for i in {1..40}; do xdpyinfo -display :0 >/dev/null 2>&1 && break || sleep 0.25; done

x11vnc -display :0 -nopw -forever -shared -quiet \
  -rfbport 5900 -listen 0.0.0.0 &

# wait forever for VNC socket
echo "Waiting for 0.0.0.0:5900..."
until (echo > /dev/tcp/127.0.0.1/5900) >/dev/null 2>&1; do
  sleep 0.5
done

source ~/.bashrc
# If args given, exec them; else run your default
if [ $# -gt 0 ]; then exec "$@"; else exec ign gazebo "${WORLD:-}"; fi
