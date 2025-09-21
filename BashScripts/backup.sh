#!/bin/bash

# A script to back up user home directories from a list in a file that's provided at CLI

# Define a dedicated backup directory for better security
BACKUP_DEST="/var/backups/users"
mkdir -p "$BACKUP_DEST" # Ensure the directory exists

file="$1"

# Read file line by line for robustness
while IFS= read -r username; do

 # Check if the user's home directory exists before backing up
    if [ ! -d "/home/$username" ]; then
        echo "Warning: Home directory for user '$username' does not exist. Skipping..."
        continue # Skip to the next line in the file
    fi

echo "$username will be backed up"

# Backup initiated and moving to the backup destination
sudo tar czvf $username.tar.gz /home/$username

mv $username.tar.gz $BACKUP_DEST

done < "$file"

echo "All backups processed."
