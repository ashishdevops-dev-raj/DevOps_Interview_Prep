# Shell Scripting Commands Reference

## Basic Shell Commands

### File Operations
```bash
# Create file
touch file.txt

# Copy file
cp source.txt dest.txt
cp -r source_dir dest_dir    # Recursive copy

# Move/Rename
mv old.txt new.txt
mv file.txt /path/to/dest/

# Remove
rm file.txt
rm -rf directory/            # Remove directory recursively

# Create directory
mkdir dirname
mkdir -p path/to/dir         # Create parent directories

# List files
ls
ls -la                       # Long format, all files
ls -lh                       # Human-readable sizes
ls -lt                       # Sort by time
```

### File Viewing
```bash
cat file.txt                 # Display entire file
less file.txt                # Page through file
more file.txt                # Page through file
head -n 10 file.txt          # First 10 lines
tail -n 10 file.txt          # Last 10 lines
tail -f file.txt             # Follow file (watch for changes)
```

### File Searching
```bash
grep "pattern" file.txt      # Search for pattern
grep -r "pattern" dir/        # Recursive search
grep -i "pattern" file.txt   # Case insensitive
grep -v "pattern" file.txt   # Invert match
grep -n "pattern" file.txt   # Show line numbers

find . -name "*.txt"         # Find files by name
find . -type f -size +100M   # Find large files
find . -mtime -7             # Files modified in last 7 days
```

### Text Processing
```bash
# Cut
cut -d: -f1 /etc/passwd      # Cut by delimiter
cut -c1-10 file.txt           # Cut by character

# Sort
sort file.txt                # Sort lines
sort -n file.txt             # Numeric sort
sort -r file.txt             # Reverse sort
sort -u file.txt             # Unique sort

# Uniq
uniq file.txt                # Remove duplicates
uniq -c file.txt             # Count occurrences

# Awk
awk '{print $1}' file.txt     # Print first column
awk -F: '{print $1}' file.txt # Custom delimiter
awk '/pattern/ {print}' file.txt # Pattern matching

# Sed
sed 's/old/new/g' file.txt    # Replace text
sed -i 's/old/new/g' file.txt # In-place edit
sed -n '10,20p' file.txt      # Print lines 10-20
sed '/pattern/d' file.txt     # Delete lines
```

### Process Management
```bash
ps                           # List processes
ps aux                       # All processes
ps aux | grep process        # Find process
top                          # Interactive process viewer
htop                         # Enhanced top
kill PID                     # Kill process
kill -9 PID                  # Force kill
killall process_name         # Kill by name
pkill pattern                # Kill by pattern
jobs                         # List jobs
fg %1                        # Bring job to foreground
bg %1                        # Send job to background
nohup command &              # Run in background
```

### System Information
```bash
uname -a                     # System information
hostname                     # Hostname
uptime                       # System uptime
whoami                       # Current user
id                           # User ID information
df -h                        # Disk space
du -h                        # Directory usage
free -h                      # Memory usage
lscpu                        # CPU information
```

### Network Commands
```bash
ping hostname                 # Test connectivity
traceroute hostname           # Trace route
netstat -tulpn                # Network connections
ss -tulpn                     # Socket statistics
curl url                      # HTTP request
wget url                      # Download file
ifconfig                      # Network interface
ip addr                       # IP addresses
```

### Permissions
```bash
chmod 755 file.sh            # Change permissions
chmod +x file.sh             # Add execute permission
chmod -R 755 directory/      # Recursive
chown user:group file        # Change ownership
chgrp group file             # Change group
```

### Compression
```bash
tar -czf archive.tar.gz files/    # Create compressed archive
tar -xzf archive.tar.gz           # Extract archive
tar -xzf archive.tar.gz -C dest/ # Extract to directory
zip archive.zip files/            # Create zip
unzip archive.zip                 # Extract zip
gzip file.txt                     # Compress file
gunzip file.txt.gz                # Decompress
```

## Shell Scripting Basics

### Shebang
```bash
#!/bin/bash                   # Bash script
#!/bin/sh                     # POSIX shell
#!/usr/bin/env bash           # Portable shebang
```

### Variables
```bash
VAR="value"                   # Set variable
echo $VAR                     # Use variable
echo ${VAR}                   # Explicit variable
readonly VAR="value"          # Read-only variable
export VAR="value"            # Export to environment
```

### Special Variables
```bash
$0                            # Script name
$1, $2, ...                   # Positional parameters
$#                            # Number of arguments
$@                            # All arguments
$*                            # All arguments (single string)
$?                            # Exit status of last command
$$                            # Process ID
$!                            # Background process ID
```

### Conditionals
```bash
# If statement
if [ condition ]; then
    commands
fi

# If-else
if [ condition ]; then
    commands
else
    commands
fi

# Case statement
case $var in
    pattern1)
        commands
        ;;
    pattern2)
        commands
        ;;
esac
```

### Loops
```bash
# For loop
for i in 1 2 3; do
    echo $i
done

# For loop with range
for i in {1..10}; do
    echo $i
done

# While loop
while [ condition ]; do
    commands
done

# Until loop
until [ condition ]; do
    commands
done
```

### Functions
```bash
function_name() {
    local var="value"         # Local variable
    commands
    return 0
}

# Call function
function_name
```

### Input/Output
```bash
read variable                 # Read input
read -p "Prompt: " variable   # Read with prompt
read -s variable              # Silent input (password)

echo "text"                   # Print text
echo -n "text"                # No newline
printf "format" args          # Formatted output
```

### Error Handling
```bash
set -e                        # Exit on error
set -u                        # Exit on undefined variable
set -o pipefail               # Exit on pipe failure
command || exit 1             # Exit if command fails
```

### Redirection
```bash
command > file                # Redirect stdout
command >> file               # Append stdout
command < file                # Redirect stdin
command 2> file               # Redirect stderr
command &> file               # Redirect both
command 2>&1                  # Redirect stderr to stdout
```

### Pipes
```bash
command1 | command2           # Pipe output
command1 | tee file           # Pipe and save to file
```

## Advanced Shell Features

### Arrays
```bash
arr=(item1 item2 item3)       # Create array
echo ${arr[0]}                # Access element
echo ${arr[@]}                # All elements
echo ${#arr[@]}               # Array length
```

### String Operations
```bash
${var#pattern}                # Remove shortest prefix
${var##pattern}               # Remove longest prefix
${var%pattern}                # Remove shortest suffix
${var%%pattern}               # Remove longest suffix
${var/old/new}                # Replace first occurrence
${var//old/new}               # Replace all occurrences
${var:start:length}           # Substring
${#var}                       # String length
```

### Arithmetic
```bash
$((expression))               # Arithmetic expansion
let "result = 1 + 2"          # Arithmetic assignment
expr 1 + 2                    # Expression evaluation
```

### Test Conditions
```bash
[ -f file ]                   # File exists and is regular
[ -d dir ]                    # Directory exists
[ -r file ]                   # File is readable
[ -w file ]                   # File is writable
[ -x file ]                   # File is executable
[ -z string ]                 # String is empty
[ -n string ]                 # String is not empty
[ str1 = str2 ]               # Strings are equal
[ str1 != str2 ]              # Strings are not equal
[ num1 -eq num2 ]             # Numbers are equal
[ num1 -lt num2 ]             # num1 less than num2
[ num1 -gt num2 ]             # num1 greater than num2
```

## Best Practices

### Script Structure
```bash
#!/bin/bash
set -euo pipefail             # Error handling
set -x                        # Debug mode (optional)

# Script metadata
SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Functions
function_name() {
    local var="$1"
    # Function body
}

# Main script
main() {
    # Main logic
}

# Run main function
main "$@"
```

### Error Handling
```bash
# Check if command exists
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# Check file exists
if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    exit 1
fi
```

### Logging
```bash
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting script"
log "Error occurred" >&2      # Log to stderr
```

