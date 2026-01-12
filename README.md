# cmd-shim

A lightweight collection of Windows Batch scripts that map common Linux commands (`ls`, `rm`, `sudo`, etc.) to their Windows equivalents.

## Installation

Run `install.bat` to automatically install the scripts to `%USERPROFILE%\.local\bin` and add that directory to your User Path.

### Options

The installation script supports several flags to include additional toolsets:

| Flag | Description |
| :--- | :--- |
| (None) | Installs **Common** commands only. |
| `--net` | Includes **Network** tools (e.g., ifconfig, wget). |
| `--sysinternals` | Includes wrappers for **Sysinternals** tools (e.g., top, strings). |
| `--customs` | Includes scripts from the `src/customs` directory. |
| `--all` | Installs all available script sets. |

## Supported Commands

### File Operations
| Command | Mapping / Function |
| :--- | :--- |
| `ls` | `dir` |
| `ll` | `dir /Q /N` |
| `rm` | `del` / `rd` (Supports `-rf`) |
| `cp` | `copy` |
| `mv` | `move` |
| `touch` | Creates empty file or updates timestamp. |
| `pwd` | Prints current directory. |
| `du` | Disk usage estimate. |
| `zip`/`unzip` | Archives/Extracts files (via PowerShell). |
| `open` | Opens file/folder (like `start`). |

### Text Processing
| Command | Mapping / Function |
| :--- | :--- |
| `cat` | `type` |
| `grep` | `findstr` |
| `tail` | PowerShell `Get-Content -Tail` wrapper. |
| `less` | `more` |
| `diff` | `fc` (File Compare). |
| `wc` | Word/Line count. |
| `base64` | Encode/Decode base64. |

### System & Utils
| Command | Mapping / Function |
| :--- | :--- |
| `sudo` | `runas` (Administrator). |
| `clear` | `cls` |
| `ps` | `tasklist` |
| `kill` | `taskkill` |
| `history` | `doskey /history` |
| `which` | `where` |
| `uname` | System information. |
| `uptime` | System uptime. |
| `man` | Shows help for command. |
| `sleep` | Pauses execution. |
| `halt`/`reboot` | Power management shortcuts. |

### Network Tools (--net)
| Command | Mapping / Function |
| :--- | :--- |
| `ifconfig` | `ipconfig` |
| `wget` | PowerShell download wrapper. |
| `dig` | DNS lookup (nslookup wrapper). |
| `nc` | Netcat equivalent. |

### Sysinternals Wrappers (--sysinternals)
*Requires to install Sysinternals Suite and have it in your PATH.*
*(More wrappers are being added)*

| Command | Mapping |
| :--- | :--- |
| `top` | `procexp` (Process Explorer) |
| `lsof` | `handle` |
| `strings` | `strings` |
| `shred` | `sdelete` |

## License

[MIT License](LICENSE)