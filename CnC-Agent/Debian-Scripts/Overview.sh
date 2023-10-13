#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

me=$(basename "$0")
databaseip=$(cat "$dbip")

hostname=$(echo $HOSTNAME)

# Check if the hostname already exists in the database
existing_data=$(curl -s "http://$databaseip:3000/read/hostname/$hostname")

if [ -n "$existing_data" ]; then
    # Hostname exists, update the data
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
    # Add other OS version checks here if needed
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi

    distro="$OS $VER"

    # Define your REST API endpoint for updating data
    API_ENDPOINT="http://$databaseip:3000/update/info/$hostname"

    # Define the data to be sent to the API
    DATA='{
        "hostname": "'"$hostname"'",
        "ipaddress": "'"$ip_address"'",
        "macaddress": "'"$mac_address"'",
        "distro": "'"$distro"'",
        "packages": "'"$packages"'"
    }'

    # Debugging: Print the data being sent
    echo "Updating data: $DATA"

    # Send a POST request to the API to update data
    response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$API_ENDPOINT")

    # Debugging: Print the response from the API
    echo "API response: $response"

    if [ "$response" == "Data updated" ]; then
        echo "Data updated from $me."
    else
        echo "Data update failed from $me."
    fi
else
    # Hostname doesn't exist, insert new data
    echo "Hostname $hostname doesn't exist in the database. Inserting new data..."
    source ~/CnC-WebGUI/insert_script.sh
fi
