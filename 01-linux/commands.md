# Linux Commands Cheat Sheet

## File Operations

### Basic Commands
- `ls` - List directory contents
- `ls -la` - List all files with details
- `cd` - Change directory
- `pwd` - Print working directory
- `mkdir` - Create directory
- `rm` - Remove file
- `rm -rf` - Remove directory recursively
- `cp` - Copy file/directory
- `mv` - Move/rename file
- `touch` - Create empty file
- `cat` - Display file content
- `less` / `more` - View file page by page
- `head` - Display first lines
- `tail` - Display last lines
- `tail -f` - Follow file changes in real-time

### File Permissions
- `chmod` - Change file permissions
  - `chmod 755 file.sh` - rwxr-xr-x
  - `chmod +x file.sh` - Add execute permission
- `chown` - Change file ownership
  - `chown user:group file`
- `chgrp` - Change group ownership

### File Search
- `find` - Search for files
  - `find /path -name "*.log"`
  - `find /path -type f -mtime +7` - Files older than 7 days
- `grep` - Search text in files
  - `grep -r "pattern" /path`
  - `grep -i` - Case insensitive
  - `grep -v` - Invert match
- `locate` - Find files by name (uses database)
- `which` - Locate a command
- `whereis` - Locate binary, source, and manual files

## System Information

### System Status
- `uname -a` - System information
- `uptime` - System uptime and load
- `whoami` - Current user
- `who` - Currently logged in users
- `w` - Who is logged in and what they're doing
- `df -h` - Disk space usage
- `du -h` - Directory space usage
- `du -sh *` - Size of each directory
- `free -h` - Memory usage
- `top` - Process monitor (interactive)
- `htop` - Enhanced process monitor
- `ps aux` - List all processes
- `ps aux | grep process` - Find specific process

### Hardware Information
- `lscpu` - CPU information
- `lsblk` - Block devices
- `lspci` - PCI devices
- `lsusb` - USB devices
- `dmidecode` - Hardware information

## Process Management

- `ps` - Process status
- `kill` - Terminate process
  - `kill -9 PID` - Force kill
- `killall` - Kill processes by name
- `pkill` - Kill processes by pattern
- `nohup` - Run command immune to hangups
- `jobs` - List jobs
- `fg` - Bring job to foreground
- `bg` - Send job to background
- `nice` - Run with modified priority
- `renice` - Change priority of running process

## Network Commands

- `ifconfig` / `ip addr` - Network interface configuration
- `netstat` - Network connections
  - `netstat -tulpn` - All listening ports
- `ss` - Socket statistics
- `ping` - Test connectivity
- `traceroute` - Trace route to host
- `curl` - Transfer data from server
- `wget` - Download files
- `dig` - DNS lookup
- `nslookup` - DNS query
- `hostname` - Show/set hostname
- `route` - Show/manipulate routing table

## Text Processing

- `grep` - Pattern matching
- `sed` - Stream editor
  - `sed 's/old/new/g' file` - Replace text
- `awk` - Text processing
- `cut` - Extract columns
- `sort` - Sort lines
- `uniq` - Remove duplicates
- `wc` - Word count
  - `wc -l` - Line count
- `tr` - Translate characters
- `diff` - Compare files
- `patch` - Apply diff file

## Archive and Compression

- `tar` - Archive files
  - `tar -czf archive.tar.gz files/` - Create compressed archive
  - `tar -xzf archive.tar.gz` - Extract archive
- `zip` - Create zip archive
- `unzip` - Extract zip archive
- `gzip` - Compress files
- `gunzip` - Decompress files

## Package Management

### Debian/Ubuntu (apt)
- `apt update` - Update package list
- `apt upgrade` - Upgrade packages
- `apt install package` - Install package
- `apt remove package` - Remove package
- `apt search package` - Search packages
- `apt list --installed` - List installed packages

### RedHat/CentOS (yum/dnf)
- `yum update` - Update packages
- `yum install package` - Install package
- `yum remove package` - Remove package
- `yum search package` - Search packages
- `yum list installed` - List installed packages

## System Services

- `systemctl` - Systemd service management
  - `systemctl start service` - Start service
  - `systemctl stop service` - Stop service
  - `systemctl restart service` - Restart service
  - `systemctl status service` - Check status
  - `systemctl enable service` - Enable on boot
  - `systemctl disable service` - Disable on boot
  - `systemctl list-units` - List all services

## Logs

- `journalctl` - Systemd journal
  - `journalctl -u service` - Service logs
  - `journalctl -f` - Follow logs
  - `journalctl --since "1 hour ago"`
- `/var/log/` - Log directory
  - `/var/log/syslog` - System log
  - `/var/log/auth.log` - Authentication log
  - `/var/log/kern.log` - Kernel log

## Environment Variables

- `env` - Display environment variables
- `export VAR=value` - Set environment variable
- `echo $VAR` - Display variable
- `unset VAR` - Unset variable
- `$PATH` - Command search path
- `$HOME` - Home directory
- `$USER` - Current user

## Redirection and Pipes

- `>` - Redirect output (overwrite)
- `>>` - Redirect output (append)
- `<` - Redirect input
- `|` - Pipe output to another command
- `2>&1` - Redirect stderr to stdout
- `&>` - Redirect both stdout and stderr

## Useful Shortcuts

- `Ctrl+C` - Interrupt current command
- `Ctrl+Z` - Suspend process
- `Ctrl+D` - Exit shell / EOF
- `Ctrl+L` - Clear screen
- `!!` - Repeat last command
- `!$` - Last argument of previous command
- `history` - Command history
- `!n` - Execute command number n from history

