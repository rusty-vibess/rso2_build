#!/usr/bin/env bash
set -euo pipefail

LISTEN_PORT="${LISTEN_PORT:-6080}"
TARGET_HOST="${TARGET_HOST:-host.docker.internal}"
TARGET_PORT="${TARGET_PORT:-5900}"
NOVNC_WEB="${NOVNC_WEB:-/usr/share/novnc}"

trap 'kill 0 || true' EXIT

while true; do
  echo "Waiting for ${TARGET_HOST}:${TARGET_PORT}..."
  until (echo >"/dev/tcp/${TARGET_HOST}/${TARGET_PORT}") >/dev/null 2>&1; do
    sleep 0.5
  done

  echo "Starting websockify on :${LISTEN_PORT} -> ${TARGET_HOST}:${TARGET_PORT}"
  websockify --web="${NOVNC_WEB}" 0.0.0.0:${LISTEN_PORT} ${TARGET_HOST}:${TARGET_PORT} || true

  echo "websockify exited; retrying..."
  sleep 1
done
