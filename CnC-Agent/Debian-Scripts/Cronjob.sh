#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Fetch existing data from the API
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn")

# Create an array to store unique cron jobs
unique_cronjobs=(Packages.sh, Overview.sh, Cronjob.sh)

# Read the user's crontab and store unique cron jobs in the array
while IFS= read -r line; do
    # Check if the cron job is not in the unique_cronjobs array
    if [[ ! " ${unique_cronjobs[@]} " =~ " $line " ]]; then
        unique_cronjobs+=("$line")
    fi
done < <(crontab -l)

# Get the "id" from the existing data
existing_id=$(echo "$existing_data" | jq -r .id)

# Check if data already exists
if [ -n "$existing_data" ]; then
    echo "Data with id $existing_id exists. Updating..."
    # Extract existing crontab data
    existing_cronjobs=$(echo "$existing_data" | jq -r .cronjobsscripts)

    # Compare existing data with new data
    if [ "$existing_cronjobs" != "${unique_cronjobs[*]}" ]; then
        # Prepare the data for update
        DATA='{
            "id": "'"$existing_id"'",
            "cronjobsscripts": "'"$unique_cronjobs[*]"'"
        }'

        # Send a PUT request to update the data
        response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/update/cronjobs/$existing_id")

        if [ "$response" == "Data updated" ]; then
            echo "Data updated from $me."
        else
            echo "Data update failed."
        fi
    fi
else
    echo "Data for id $existing_id does not exist. Inserting..."
    # Prepare the data for insertion
    DATA='{
        "cronjobsscripts": "'"$unique_cronjobs[*]"'"
    }'

    # Send a POST request to insert the data
    response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/create/cronjobs")

    if [ "$response" == "Data inserted" ]; then
        echo "Data inserted from $me."
    else
        echo "Data insert failed."
    fi
fi
