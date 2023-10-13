#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")
id=1  # Replace this with the desired id

# Fetch existing data from the API based on "id"
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$id")

# Get the user's crontab
user_crontab=$(crontab -l)

# Prepare the data for insertion or update
DATA='{
    "hostname": "'"$hn"'",
    "id": "'"$id"'",
    "cronjobsscripts": "'"$user_crontab"'"
}'

# Check if data already exists
if [ -n "$existing_data" ]; then
    echo "Data for id $id exists. Updating..."
    # Extract the existing crontab data
    existing_cronjobs=$(echo "$existing_data" | jq -r .cronjobsscripts)

    # Compare existing data with new data
    if [ "$existing_cronjobs" != "$user_crontab" ]; then
        # Send a PUT request to update the data
        response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/update/cronjobs/$id")

        if [ "$response" == "Data updated" ]; then
            echo "Data updated from $me."
        else
            echo "Data update failed."
        fi
    fi
else
    echo "Data for id $id does not exist. Inserting..."
    # Send a POST request to insert the data
    response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/create/cronjobs")

    if [ "$response" == "Data inserted" ]; then
        echo "Data inserted from $me."
    else
        echo "Data insert failed."
    fi
fi
