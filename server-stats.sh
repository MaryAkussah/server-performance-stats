#!/usr/bin/env bash

# server-stats.sh - Basic server performance statistics
# Works on most modern Linux distributions (uses coreutils + procfs)

set -euo pipefail

info() {
  printf "\e[1;34m%s\e[0m\n" "$1"
}

section() {
  printf "\n\e[1;33m==> %s\e[0m\n" "$1"
}

# CPU usage (total)
section "CPU Usage"
if command -v top >/dev/null 2>&1; then
  # Provide a human-readable summary of CPU usage.
  top -bn1 | awk 'BEGIN {OFS=""} /Cpu\(s\)/ {print "Total: " $2 " user, " $4 " system, " $10 " idle"; exit}'
else
  echo "top not found; unable to show CPU usage"
fi

# Memory usage
section "Memory Usage"
if command -v free >/dev/null 2>&1; then
  free -h | awk 'NR==1{print; next} NR==2{printf "%-10s %-10s %-10s %-10s\n", $1, $2, $3, $4; printf "Used: %s (%s used) / Free: %s\n", $3, sprintf("%.2f%%", $3/$2*100), $4; exit}'
else
  echo "free not found; unable to show memory usage"
fi

# Disk usage
section "Disk Usage"
if command -v df >/dev/null 2>&1; then
  df -h --total | awk 'END {print "Total: " $3 " used / " $4 " free (" $5 ")"}'
  df -h --total | head -n -1
else
  echo "df not found; unable to show disk usage"
fi

# Top processes
section "Top 5 Processes by CPU Usage"
ps -eo pid,comm,pcpu,pmem --sort=-pcpu | head -n 6

section "Top 5 Processes by Memory Usage"
ps -eo pid,comm,pcpu,pmem --sort=-pmem | head -n 6

# Optional additional stats
section "Additional Info"
if [ -f /etc/os-release ]; then
  . /etc/os-release
  printf "OS: %s %s\n" "${NAME:-Unknown}" "${VERSION:-}" | sed 's/ $//'
fi

if command -v uptime >/dev/null 2>&1; then
  uptime
fi

if command -v who >/dev/null 2>&1; then
  echo "Logged in users: $(who | wc -l)"
fi

# Failed login attempts (best effort)
if [ -r /var/log/auth.log ]; then
  echo "Failed SSH logins (last 30):"
  grep -i "failed password" /var/log/auth.log | tail -n 30 || true
elif command -v lastb >/dev/null 2>&1; then
  echo "Failed login attempts (last 10):"
  lastb -n 10
fi
