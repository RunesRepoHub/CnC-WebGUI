#!/bin/bash

# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
me=$(basename "$0")

# Escape double quotes in variables
HOSTNAME=$(echo "$HOSTNAME" | sed 's/"/\\"/g')

# Define your REST API endpoint for reading and updating data
READ_API_ENDPOINT="http://$databaseip:3000/read/packages/$HOSTNAME"
CREATE_API_ENDPOINT="http://$databaseip:3000/create/packages"
UPDATE_API_ENDPOINT="http://$databaseip:3000/update/packages"
DELETE_API_ENDPOINT="http://$databaseip:3000/delete/packages"

# Send a GET request to retrieve existing data
existing_data=$(curl -s -X GET "$READ_API_ENDPOINT")

# Extract the ID for the hostname from the JSON object
id=$(echo "$existing_data" | jq -r '.id')

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

# Debugging: Print the data being sent
# echo "Sending data: $DATA"

# Check if an ID was found
if [ -z "$id" ]; then
    # No existing data found, send a POST request to insert data
    response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$CREATE_API_ENDPOINT" >/dev/null 2>&1)
    echo "Data inserted from $me."
else
    # Send a DELETE request to the API to delete old data
    delete_response=$(curl -X DELETE "$DELETE_API_ENDPOINT/$id" >/dev/null 2>&1)
    # Send a PUT request to update data with the retrieved ID
    update_response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "$UPDATE_API_ENDPOINT/$id" >/dev/null 2>&1)
    echo "Data updated and old data deleted from $me."
fi

# Debugging: Print the response from the API
# echo "API response: $response"
