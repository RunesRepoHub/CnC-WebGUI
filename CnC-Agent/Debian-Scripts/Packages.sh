#!/bin/bash

# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
me=$(basename "$0")

# Escape double quotes in variables
HOSTNAME=$(echo "$HOSTNAME" | sed 's/"/\\"/g')

# Define your REST API endpoints
UPDATE_API_ENDPOINT="http://$databaseip:3000/update/packages"

# Send a GET request to retrieve existing data
existing_data=$(curl -s -X GET "$UPDATE_API_ENDPOINT/$HOSTNAME")

# Define the data to be sent to the API
DATA=$(cat <<EOF
{
    "hostname": "$HOSTNAME",
    "git": "$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "wget": "$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}' | sed 's/"/\\"/g')",
    "sudo": "$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}' | sed 's/"/\\"/g')",
    "python": "$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "python3": "$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "nettools": "$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}' | sed 's/"/\\"/g')",
    "mysql": "$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "libpython": "$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "dockercecli": "$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}' | sed 's/"/\\"/g')",
    "dockercomposeplugin": "$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}' | sed 's/"/\\"/g')",
    "curl": "$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}' | sed 's/"/\\"/g')",
    "containerd": "$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}' | sed 's/"/\\"/g')"
}
EOF
)

# Check if existing data is empty or not
if [ -z "$existing_data" ]; then
    # Send a POST request to the API to insert data
    response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$UPDATE_API_ENDPOINT")
    echo "Data inserted from $me."
else
    # Send a PUT request to the API to update data
    response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "$UPDATE_API_ENDPOINT/$HOSTNAME")
    echo "Data updated from $me."
fi

# Debugging: Print the response from the API
# echo "API response: $response"
