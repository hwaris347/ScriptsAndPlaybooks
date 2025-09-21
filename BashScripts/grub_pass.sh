#!/bin/bash

# A script to set a GRUB password for selected menu entries.
# This script requires root privileges to run.

# Step 1: Generating the PBKDF2 encrypted password hash.

echo "Generating encrypted password and printing it: "
temp_password=$(openssl rand -base64 20 | tr -dc 'A-Za-z0-9' | head -c 14)
hostname=$(hostname)

# Displaying the Hostname and Password generated (store in a vault, eg. Keeper etc.)
echo "The password for $hostname is $temp_password" 

# Taking the generated password and creating and printing the hash for grub
hashed_password=$(printf "%s\n%s\n" "$temp_password" "$temp_password" | grub-mkpasswd-pbkdf2 | awk '/grub\.pbkdf2/ {print $NF}')

echo "Provided output of the password hash: $hashed_password"

echo $hashed_password is the
if [ -z "$hashed_password" ]; then
    echo "Error: Could not generate password hash. Aborting."
    exit 1
fi
echo "Password hash generated successfully."

# Step 2: Edit /etc/grub.d/40_custom
# Add the superuser and password_pbkdf2 lines to the 40_custom file.
echo "Editing /etc/grub.d/40_custom..."
echo "set superusers=\"admin\"" | tee -a /etc/grub.d/40_custom
echo "password_pbkdf2 admin $hashed_password" | tee -a /etc/grub.d/40_custom
echo "Content added to 40_custom."

# Step 3: Edit /etc/grub.d/10_linux to add --unrestricted flag
# Use sed to add --unrestricted to the menuentry lines.
echo "Editing /etc/grub.d/10_linux..."
sudo sed -i "/menuentry '/s/\${CLASS}/\${CLASS} --unrestricted/" /etc/grub.d/10_linux
echo "Unrestricted flag added to 10_linux."

# Step 4: Ensure /etc/default/grub has the correct timeout settings
# Use sed to set or replace the GRUB_TIMEOUT_STYLE and GRUB_TIMEOUT values.
echo "Editing /etc/default/grub for timeout settings..."
sudo sed -i '/^GRUB_TIMEOUT_STYLE=/c\GRUB_TIMEOUT_STYLE=menu' /etc/default/grub
sudo sed -i '/^GRUB_TIMEOUT=/c\GRUB_TIMEOUT=10' /etc/default/grub
echo "Timeout settings configured in grub."

# Step 5: Update grub
echo "Updating GRUB..."
sudo update-grub
echo "GRUB has been successfully updated. The new password is set."
echo "--- Script finished. ---"
