#!/bin/bash

# Set default values
USERNAME=${USERNAME:-test}
PASSWORD=${PASSWORD:-test}
USER_UID=${USER_UID:-1001}

# Create user if it doesn't exist
if ! id "$USERNAME" &>/dev/null; then
    echo "Creating user: $USERNAME"
    useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u $USER_UID $USERNAME
fi

# Set password
echo "Setting password for user: $USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Start SSH daemon in foreground
exec /usr/sbin/sshd -D