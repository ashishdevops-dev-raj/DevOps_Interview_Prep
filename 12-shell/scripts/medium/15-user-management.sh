#!/bin/bash
# Medium Level Script 15: User Management
# Display user information

read -p "Enter username (or 'all' for all users): " username

if [ "$username" = "all" ]; then
    echo "=== All Users ==="
    cut -d: -f1 /etc/passwd | sort
    echo ""
    echo "Total users: $(cut -d: -f1 /etc/passwd | wc -l)"
else
    if id "$username" &>/dev/null; then
        echo "=== User Information: $username ==="
        echo "UID: $(id -u "$username")"
        echo "GID: $(id -g "$username")"
        echo "Groups: $(id -Gn "$username")"
        echo "Home: $(eval echo ~$username)"
        echo "Shell: $(getent passwd "$username" | cut -d: -f7)"
        echo "Last login: $(last -n 1 "$username" 2>/dev/null | head -1 || echo "Never")"
    else
        echo "User not found: $username"
    fi
fi

