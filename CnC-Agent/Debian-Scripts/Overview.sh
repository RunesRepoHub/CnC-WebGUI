#!/bin/bash
me=$(basename "$0")
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)

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

disto="$OS $VER"

# Define your REST API endpoint for updating/inserting data
API_ENDPOINT="http://$databaseip:3000/create/info"

# Define the data to be sent to the API
DATA='{
    "hostname": "'"$hostname"'",
    "ipaddress": "'"$ip_address"'",
    "macaddress": "'"$mac_address"'",
    "disto": "'"$disto"'",
    "packages": "'"$packages"'"
}'

# Send a POST request to the API to update or insert data
response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$API_ENDPOINT")

# Check the response from the API
if [ "$response" == "Data updated" ]; then
    echo "Data updated from $me."
else
    echo "Data inserted from $me."
fi