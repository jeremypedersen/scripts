#!/bin/bash

# Check if a PID was passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <PID>"
  exit 1
fi

# PID of the process to check, taken from the first script argument
PID=$1

# Loop indefinitely until the process is not found
while true; do
  if ! ps -p $PID > /dev/null 2>&1; then
    echo "Process $PID not found. Triggering shutdown."
    # Shutdown command
    # Use 'shutdown now' for immediate shutdown
    # Use 'systemctl poweroff' for systemd-based systems
    unmount-onedrive
    unmount-pictures
    shutdown now
    # If you need a scheduled shutdown, use 'shutdown -h +time' where 'time' is in minutes.
    break
  fi
  # Wait for a bit before checking again
  echo "$PID still running, sleeping for 2 seconds"
  sleep 2
done
