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
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

distro="$OS $VER"

# Define your REST API endpoint for querying data
API_ENDPOINT="http://$databaseip:3000/read/packages/$hostname"

# Send a GET request to the API to retrieve data
existing_data=$(curl -X GET -H "Content-Type: application/json" "$API_ENDPOINT")

# Check if existing_data is empty
if [ -z "$existing_data" ]; then
    # Data is empty, use POST to insert data
    # Define your REST API endpoint for inserting data
    API_ENDPOINT="http://$databaseip:3000/create/packages"
    METHOD="POST"
    updated_data=$(cat <<EOF
{
    "hostname": "$hostname",
    "ipaddress": "$ip_address",
    "macaddress": "$mac_address",
    "distro": "$distro",
    "packages": "$packages"
}
EOF
)
else
    # Data exists, use PUT to update the existing entry
    # Define your REST API endpoint for updating data
    API_ENDPOINT="http://$databaseip:3000/update/packages/$hostname"
    METHOD="PUT"
    updated_data=$(cat <<EOF
{
    "packages": "$packages"
}
EOF
)
fi

# Debugging: Print the data being sent
echo "Sending data: $updated_data"

# Send the appropriate request to update or insert data
response=$(curl -X $METHOD -H "Content-Type: application/json" -d "$updated_data" "$API_ENDPOINT")

# Debugging: Print the response from the API
echo "API response: $response"

if [ "$METHOD" == "PUT" ]; then
    echo "Data updated from $me."
else
    echo "Data inserted from $me."
fi
