#!/bin/bash

# This script creates a backup of a user's sudoers.d file
# and then copies a new file from a temporary location to the /etc/sudoers.d directory.

# Reason for script: original sudoers file was to restrictive and prevented sudo access
# Replacing the file with a more expansive list of commands. 

USERNAME="username"
NEW_SUDOERS_FILE="username"

# The temporary path where the new file is located.
TEMP_PATH="/var/tmp"

# Script

echo "Starting the sudoers file management process for user: $USERNAME"

# 1: Create a backup of the existing sudoers file.
# cp was one of few commands allowed in orginial sudoers file, making use of that

if [ -f "/etc/sudoers.d/$USERNAME" ]; then
    echo "Creating backup of /etc/sudoers.d/$USERNAME..."
    sudo cp "/etc/sudoers.d/$USERNAME" "/etc/sudoers.d/$USERNAME.bck"
    if [ $? -eq 0 ]; then
        echo "Backup created successfully at /etc/sudoers.d/$USERNAME.bck"
    else
        echo "Failed to create backup. Exiting."
        exit 1
    fi
else
    echo "No existing sudoers file found for $USERNAME. Skipping backup."
fi

# 2: Copy the new sudoers file from the temporary directory.

echo "Copying new file from $TEMP_PATH/$NEW_SUDOERS_FILE to /etc/sudoers.d/$USERNAME..."
sudo cp "$TEMP_PATH/$NEW_SUDOERS_FILE" "/etc/sudoers.d/$USERNAME"
if [ $? -eq 0 ]; then
    echo "File copied successfully."
else
    echo "Failed to copy the new file. Exiting."
    exit 1
fi

echo "Process completed."
