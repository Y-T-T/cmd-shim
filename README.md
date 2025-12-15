# cmd-shim

A lightweight collection of Windows Batch scripts that map common Linux commands (`ls`, `rm`, `sudo`, etc.) to their Windows equivalents.

Designed to maintain muscle memory when switching between Linux and Windows CMD.

## Installation

1. Clone this repository.
2. Add the `bin` directory to your Windows **User Path** environment variable.

### Quick Setup
Run `install.bat` to automatically append the `bin` directory to your User Path.

## Supported Commands

| Command | Windows Equivalent | Note |
| :--- | :--- | :--- |
| `ls` | `dir` | Defaults to specific layouts. |
| `ll` | `dir /Q /N` | Shows owner and long format. |
| `rm` | `del` / `rd` | Supports `-rf` for recursive directory deletion. |
| `cp` | `copy` | Supports overwrite by default. |
| `mv` | `move` | |
| `cat` | `type` | |
| `grep` | `findstr` | Supports basic regex. |
| `sudo` | `runas` | Prompts for UAC (Admin) in current directory. It may conflict with Windows Developer Tool (Sudo). |
| `touch` | `type nul >` | Updates timestamp or creates empty file. |
| `which` | `where` | |
| `pwd` | `cd` | |

## License

[MIT License](LICENSE)