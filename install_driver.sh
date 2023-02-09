#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Store the name of the current script in a variable
current_script=$(basename "$0")

# Update the package list and reinstall required packages
sudo apt-get update -y
sudo apt-get install --reinstall -y git dkms build-essential linux-headers-$(uname -r) p7zip-full

# Create and change to the dev directory
mkdir ~/dev
cd ~/dev

# Download the driver package
wget https://raw.githubusercontent.com/XAIOThaifeng/realtek-linux/master/RTL8822CE/RTL8822CE_WiFi_linux_v5.7.3_35403_COEX20190531-0e0e.20191028.7z -P ~/dev

# Extract the driver package
7z x RTL8822CE_WiFi_linux_v5.7.3_35403_COEX20190531-0e0e.20191028.7z

# Rename the extracted directory
mv RTL8822CE_WiFi_linux_v5.7.3_35403_COEX20190531-0e0e.20191028 RTL8822CE

# Remove the original archive
rm RTL8822CE_WiFi_linux_v5.7.3_35403_COEX20190531-0e0e.20191028.7z

# Change to the RTL8822CE directory
cd RTL8822CE

# Make the install script executable
chmod +x *.sh

# Run the install script
./install.sh

# Remove the current script
rm -f "$current_script"
