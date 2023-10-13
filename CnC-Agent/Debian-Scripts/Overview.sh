#!/bin/bash

# Source the configuration script
source ~/CnC-WebGUI/config.sh

me=$(basename "$0")
databaseip=$(cat "$dbip")

hostname=$(echo $HOSTNAME)

ip_address=$(hostname -I | awk '{print $1}')

mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')

packages=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep  ^Inst | wc -l)

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    ...
elif [ -f /etc/redhat-release ]; then
    ...
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

distro="$OS $VER"

# Define your REST API endpoint for checking if data exists
CHECK_ENDPOINT="http://$databaseip:3000/read/info"

# Use a GET request to check if data for the current hostname exists
existing_data=$(curl -X GET -H "Content-Type: application/json" "$CHECK_ENDPOINT/$hostname")

if [ -z "$existing_data" ]; then
    # Data doesn't exist, use POST to create a new entry
    API_ENDPOINT="http://$databaseip:3000/create/info"
    METHOD="POST"
else
    # Data exists, use PUT to update the existing entry
    API_ENDPOINT="http://$databaseip:3000/update/info/$hostname"
    METHOD="PUT"
fi

# Define the data to be sent to the API
DATA='{
    "hostname": "'"$hostname"'",
    "ipaddress": "'"$ip_address"'",
    "macaddress": "'"$mac_address"'",
    "distro": "'"$distro"'",
    "packages": "'"$packages"'"
}'

# Debugging: Print the data being sent
echo "Sending data: $DATA"

# Send the appropriate request to update or create data
response=$(curl -X $METHOD -H "Content-Type: application/json" -d "$DATA" "$API_ENDPOINT")

# Debugging: Print the response from the API
echo "API response: $response"

if [ "$METHOD" == "PUT" ]; then
    echo "Data updated from $me."
else
    echo "Data inserted from $me."
fi
