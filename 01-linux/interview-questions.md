# Linux Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Linux?
Linux is an open-source, Unix-like operating system kernel. It's the foundation for various Linux distributions (distros) like Ubuntu, CentOS, RedHat, etc.

### 2. What is a Linux distribution?
A Linux distribution (distro) is a complete operating system built around the Linux kernel, including package management, desktop environment, and software.

### 3. What is the difference between Linux and Unix?
Linux is a Unix-like kernel that is open-source and free. Unix is a proprietary operating system. Linux was inspired by Unix but written from scratch.

### 4. Explain the Linux file system hierarchy.
- `/` - Root directory
- `/bin` - Essential binaries
- `/boot` - Boot loader files
- `/dev` - Device files
- `/etc` - Configuration files
- `/home` - User home directories
- `/lib` - Shared libraries
- `/opt` - Optional software
- `/proc` - Process information
- `/root` - Root user home
- `/sbin` - System binaries
- `/tmp` - Temporary files
- `/usr` - User programs
- `/var` - Variable data (logs, etc.)

### 5. What is the root user?
The root user is the superuser account with full administrative privileges. UID is 0.

### 6. How do you check your current user?
```bash
whoami
id
```

### 7. What is the difference between `su` and `sudo`?
- `su` - Switch user (requires target user's password)
- `sudo` - Execute command as another user (requires your password and sudo privileges)

### 8. How do you change file permissions?
```bash
chmod 755 file.sh
chmod +x file.sh
chmod u+x file.sh
```

### 9. Explain file permissions in Linux.
Three types of permissions:
- **Read (r)** - 4
- **Write (w)** - 2
- **Execute (x)** - 1

Three user groups:
- **Owner (u)**
- **Group (g)**
- **Others (o)**

Example: `755` = rwxr-xr-x

### 10. What is the difference between hard links and soft links?
- **Hard Link**: Points directly to the inode of a file. If original file is deleted, hard link still works. Cannot link directories.
- **Soft Link (Symbolic Link)**: Points to the path of a file. If original file is deleted, link becomes broken. Can link directories.

### 11. How do you create a symbolic link?
```bash
ln -s /path/to/file /path/to/link
```

### 12. What is a process in Linux?
A process is a running instance of a program. Each process has a unique Process ID (PID).

### 13. How do you list running processes?
```bash
ps aux
ps -ef
top
htop
```

### 14. How do you kill a process?
```bash
kill PID
kill -9 PID  # Force kill
killall processname
pkill pattern
```

### 15. What is the difference between `kill`, `killall`, and `pkill`?
- `kill PID` - Kills a specific process by PID
- `killall name` - Kills all processes matching the name
- `pkill pattern` - Kills processes matching a pattern

### 16. How do you check disk usage?
```bash
df -h          # Filesystem disk space usage
du -h          # Directory space usage
du -sh *       # Size of each directory
```

### 17. How do you check memory usage?
```bash
free -h
cat /proc/meminfo
```

### 18. How do you check CPU information?
```bash
lscpu
cat /proc/cpuinfo
nproc  # Number of CPU cores
```

### 19. What is the difference between `top` and `htop`?
`htop` is an enhanced version of `top` with better UI, colors, and easier navigation.

### 20. How do you find a file?
```bash
find /path -name "filename"
locate filename
which command
whereis command
```

### 21. What is the difference between `find` and `locate`?
- `find` - Searches filesystem in real-time (slower but current)
- `locate` - Uses a database (faster but may be outdated)

### 22. How do you search text in files?
```bash
grep "pattern" file
grep -r "pattern" /path
grep -i "pattern" file  # Case insensitive
```

### 23. How do you view file contents?
```bash
cat file
less file
more file
head file
tail file
```

### 24. How do you follow a log file in real-time?
```bash
tail -f /var/log/syslog
tail -F /var/log/file
```

### 25. Where are system logs stored?
- `/var/log/` - Main log directory
- `/var/log/syslog` - System log
- `/var/log/auth.log` - Authentication log
- `/var/log/kern.log` - Kernel log
- `journalctl` - systemd journal

### 26. How do you check network connectivity?
```bash
ping hostname
traceroute hostname
telnet hostname port
nc -zv hostname port
```

### 27. How do you check listening ports?
```bash
netstat -tulpn
ss -tulpn
lsof -i -P -n
```

### 28. What is the difference between `ifconfig` and `ip`?
- `ifconfig` - Older command for network interface configuration
- `ip` - Modern replacement with more features (part of iproute2)

### 29. How do you install packages?
```bash
# Debian/Ubuntu
apt update
apt install package

# RedHat/CentOS
yum install package
dnf install package
```

### 30. What is a package manager?
A package manager is a tool that automates installing, updating, and removing software packages.

### 31. What is the difference between `apt` and `apt-get`?
Both are package managers for Debian/Ubuntu. `apt` is a newer, user-friendly wrapper around `apt-get` with better output formatting.

### 32. What is a shell?
A shell is a command-line interface that interprets user commands and executes them.

### 33. What are common Linux shells?
- Bash (Bourne Again Shell) - Most common
- sh (Bourne Shell)
- zsh (Z Shell)
- fish (Friendly Interactive Shell)

### 34. What is a shebang line?
The first line of a script that specifies the interpreter:
```bash
#!/bin/bash
```

### 35. How do you make a script executable?
```bash
chmod +x script.sh
```

## Medium Level (Questions 36-70)

### 36. What are the different process states?
- **Running (R)** - Currently executing
- **Sleeping (S)** - Waiting for an event
- **Stopped (T)** - Stopped by a signal
- **Zombie (Z)** - Terminated but not cleaned up

### 37. What is a daemon process?
A daemon is a background process that runs continuously, typically started at system boot, and provides services to other processes.

### 38. What is a zombie process and how do you handle it?
A zombie process is a terminated process whose parent hasn't read its exit status. Usually handled by the parent process or init (PID 1) if parent dies.

### 39. What is the purpose of `/etc/passwd` and `/etc/shadow`?
- `/etc/passwd` - Contains user account information (readable by all)
- `/etc/shadow` - Contains encrypted passwords (readable only by root)

### 40. Explain the difference between `grep`, `sed`, and `awk`.
- `grep` - Search for patterns in files
- `sed` - Stream editor for filtering/transforming text
- `awk` - Programming language for text processing

### 41. How do you use `sed` to replace text?
```bash
sed 's/old/new/g' file
sed -i 's/old/new/g' file  # In-place editing
```

### 42. How do you use `awk` to print specific columns?
```bash
awk '{print $1, $3}' file
awk -F: '{print $1}' /etc/passwd
```

### 43. Explain the difference between `$*` and `$@` in bash.
- `$*` - All arguments as a single string
- `$@` - All arguments as separate strings (preserves quoting)

### 44. What is the difference between `==` and `-eq` in bash?
- `==` - String comparison
- `-eq` - Numeric comparison

### 45. Explain exit codes.
- `0` - Success
- `1-255` - Error codes
- `$?` - Contains exit code of last command

### 46. How do you redirect output?
```bash
command > file      # Overwrite
command >> file     # Append
command 2>&1        # Redirect stderr to stdout
command &> file     # Redirect both
```

### 47. What is a pipe?
A pipe (`|`) sends the output of one command as input to another:
```bash
ps aux | grep process
```

### 48. Explain systemd and its purpose.
systemd is a system and service manager that:
- Manages system services
- Handles system initialization
- Manages logging (journald)
- Handles device management

### 49. How do you check service status?
```bash
systemctl status servicename
service servicename status  # Older systems
```

### 50. How do you start/stop/restart a service?
```bash
systemctl start servicename
systemctl stop servicename
systemctl restart servicename
```

### 51. How do you enable a service to start on boot?
```bash
systemctl enable servicename
```

### 52. What is `journalctl`?
`journalctl` is a command to view systemd journal logs.

### 53. How do you view logs with `journalctl`?
```bash
journalctl -u servicename
journalctl -f
journalctl --since "1 hour ago"
```

### 54. What is cron?
Cron is a time-based job scheduler in Unix-like systems.

### 55. Explain cron and crontab.
- `cron` - Time-based job scheduler
- `crontab` - Command to edit cron jobs
- Format: `minute hour day month weekday command`

### 56. How do you edit crontab?
```bash
crontab -e  # Edit
crontab -l  # List
crontab -r  # Remove
```

### 57. What is SELinux?
Security-Enhanced Linux - A security module that provides access control security policies.

### 58. How do you check SELinux status?
```bash
getenforce
sestatus
```

### 59. What is AppArmor?
AppArmor is a Linux security module that restricts programs' capabilities with per-program profiles.

### 60. How do you check disk I/O?
```bash
iostat
iotop
```

### 61. How do you monitor system resources?
```bash
top            # Real-time process monitor
htop           # Enhanced top
free -h        # Memory usage
iostat         # I/O statistics
vmstat         # Virtual memory statistics
```

### 62. What is `nice` and `renice`?
- `nice` - Run command with modified priority
- `renice` - Change priority of running process

### 63. How do you run a process in the background?
```bash
command &
nohup command &
```

### 64. What is the difference between `&` and `nohup`?
- `&` - Runs in background, but process may be killed when terminal closes
- `nohup` - Runs immune to hangups, output goes to nohup.out

### 65. How do you compress files?
```bash
tar -czf archive.tar.gz files/
zip archive.zip files/
gzip file
```

### 66. How do you extract archives?
```bash
tar -xzf archive.tar.gz
unzip archive.zip
gunzip file.gz
```

### 67. What is the difference between `tar` and `zip`?
- `tar` - Archives files (often used with compression)
- `zip` - Archives and compresses in one step

### 68. How do you find which package provides a file?
```bash
apt-file search filename    # Debian/Ubuntu
yum provides filename       # RedHat/CentOS
```

### 69. How do you update packages?
```bash
# Debian/Ubuntu
apt update
apt upgrade

# RedHat/CentOS
yum update
dnf update
```

### 70. What is `rsync`?
`rsync` is a utility for synchronizing files and directories, useful for backups and mirroring.

## High/Advanced Level (Questions 71-100)

### 71. Explain Linux boot process.
1. BIOS/UEFI initialization
2. Bootloader (GRUB) loads
3. Kernel initialization
4. Init process (systemd) starts
5. Runlevel/target services start

### 72. What is GRUB?
GRUB (Grand Unified Bootloader) is a bootloader that loads the Linux kernel.

### 73. What is the difference between BIOS and UEFI?
- **BIOS**: Legacy firmware, MBR partitioning
- **UEFI**: Modern firmware, GPT partitioning, faster boot

### 74. Explain Linux kernel modules.
Kernel modules are pieces of code that can be loaded and unloaded into the kernel on demand.

### 75. How do you list kernel modules?
```bash
lsmod
modinfo modulename
```

### 76. How do you load/unload kernel modules?
```bash
modprobe modulename
rmmod modulename
```

### 77. What is `/proc` filesystem?
`/proc` is a virtual filesystem that provides information about processes and system information.

### 78. What is `/sys` filesystem?
`/sys` is a virtual filesystem that provides information about devices, drivers, and kernel features.

### 79. Explain Linux namespaces.
Namespaces provide isolation for processes, networking, filesystems, etc. Used by containers.

### 80. What is cgroups?
cgroups (control groups) limit and account for resource usage (CPU, memory, I/O) of process groups.

### 81. How do you check cgroup information?
```bash
cat /proc/cgroups
systemd-cgtop
```

### 82. What is systemd unit?
A systemd unit is a resource that systemd knows how to manage (service, socket, mount, etc.).

### 83. How do you create a systemd service?
Create a `.service` file in `/etc/systemd/system/` and run `systemctl daemon-reload`.

### 84. What is systemd target?
A target is a synchronization point for services, similar to runlevels in SysV init.

### 85. Explain Linux process scheduling.
Linux uses Completely Fair Scheduler (CFS) to schedule processes, ensuring fair CPU time allocation.

### 86. What is OOM Killer?
Out-of-Memory (OOM) Killer terminates processes when system runs out of memory.

### 87. How do you configure swap?
```bash
swapon /dev/sda2
swapoff /dev/sda2
swapon -s  # Show swap usage
```

### 88. What is the difference between `kill -9` and `kill -15`?
- `kill -15` (SIGTERM) - Graceful termination (default)
- `kill -9` (SIGKILL) - Forceful termination (cannot be caught)

### 89. Explain Linux file system types.
- **ext4** - Default on most Linux systems
- **XFS** - High-performance filesystem
- **Btrfs** - Copy-on-write filesystem
- **ZFS** - Advanced filesystem with snapshots

### 90. How do you check filesystem type?
```bash
df -T
lsblk -f
file -s /dev/sda1
```

### 91. What is LVM?
LVM (Logical Volume Manager) provides abstraction layer for disk management, allowing dynamic resizing.

### 92. How do you create an LVM volume?
```bash
pvcreate /dev/sda1
vgcreate myvg /dev/sda1
lvcreate -L 10G -n mylv myvg
```

### 93. What is RAID?
RAID (Redundant Array of Independent Disks) combines multiple disks for performance and/or redundancy.

### 94. Explain common RAID levels.
- **RAID 0**: Striping (performance, no redundancy)
- **RAID 1**: Mirroring (redundancy)
- **RAID 5**: Striping with parity (redundancy, performance)
- **RAID 10**: Mirroring + Striping

### 95. What is iptables?
iptables is a firewall utility for Linux that filters network packets.

### 96. What is firewalld?
firewalld is a dynamic firewall manager that provides a D-Bus interface for managing firewall rules.

### 97. What is the difference between iptables and firewalld?
- **iptables**: Direct rule management, static
- **firewalld**: Zone-based, dynamic, easier management

### 98. Explain Linux capabilities.
Capabilities divide root privileges into distinct units, allowing fine-grained permission control.

### 99. How do you set capabilities?
```bash
setcap cap_net_bind_service=+ep /path/to/binary
getcap /path/to/binary
```

### 100. What is strace?
strace is a diagnostic tool that traces system calls and signals made by a process.
