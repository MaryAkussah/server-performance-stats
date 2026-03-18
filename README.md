# Server Performance Stats

A small shell script that prints basic server performance statistics:

- Total CPU usage
- Total memory usage (free vs used, with percentage)
- Total disk usage (free vs used, with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- Additional info: OS version, uptime/load average, logged-in users, failed login attempts (best effort)

---

## ✅ Run the script

### On Linux / WSL / macOS

```bash
chmod +x server-stats.sh
./server-stats.sh
```

### On Windows (PowerShell)

This script is designed for Linux environments. Use WSL or Git Bash:

```powershell
wsl
cd /mnt/c/Users/marya/Downloads/Projects/server-performance-stats
chmod +x server-stats.sh
./server-stats.sh
```

---

## 🧰 Requirements

- Bash (Linux shell)
- `top`, `free`, `df`, `ps`, `uptime`, `who` (coreutils / procps utilities)

---

## 🌐 Project page

Replace this URL with your GitHub project page once the repo is published:

https://github.com/MaryAkussah/server-performance-stats