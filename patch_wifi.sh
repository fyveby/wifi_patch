#!/bin/bash

# This bash script will patch wifi problems on Stratus RPIs

# 1) git clone wifi patch repo
git clone https://github.com/fyveby/wifi_patch


# 1) Add blacklist brcmfmac to file /etc/modprobe.d/raspi-blacklist.conf
LINE="blacklist brcmfmac"

# Define the file to modify
FILE="/etc/modprobe.d/raspi-blacklist.conf"

# Check if the line already exists in the file
if ! grep -Fxq "$LINE" "$FILE"; then
    echo "$LINE" | sudo tee -a "$FILE"
    echo "Line added to $FILE"
else
    echo "Line already exists in $FILE"
fi

# 2) Set wifi country to US
sudo iw reg set US

# 3) Copy Ucodes to /lib/firmware
sudo cp wifi_patch/ucodes/iwlwifi-*.ucode /lib/firmware
