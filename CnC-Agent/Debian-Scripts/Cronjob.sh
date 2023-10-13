#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Fetch existing data from the API
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn")

# Create an array to store unique cron jobs
unique_cronjobs=(00 00 * * * ruby /root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh >/dev/null 2>&1, 00 00 * * * ruby /root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh >/dev/null 2>&1, 00 00 * * * ruby /root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh >/dev/null 2>&1)

# Read the user's crontab and store unique cron jobs in the array
while IFS= read -r line; do
    # Check if the cron job is not in the unique_cronjobs array
    if [[ ! " ${unique_cronjobs[@]} " =~ " $line " ]]; then
        unique_cronjobs+=("$line")
    fi
done < <(crontab -l)

# Process each unique cron job
for line in "${unique_cronjobs[@]}"; do
    # Check if data already exists
    if [ -n "$existing_data" ]; then
        echo "Data for hostname $hn exists. Updating..."
        # Extract existing crontab data
        existing_cronjobs=$(echo "$existing_data" | jq -r .cronjobsscripts)

        # Compare existing data with new data
        if [ "$existing_cronjobs" != "$line" ]; then
            # Prepare the data for update
            DATA='{
                "hostname": "'"$hn"'",
                "cronjobsscripts": "'"$line"'"
            }'

            # Send a PUT request to update the data
            response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/update/cronjobs/$hn")

            if [ "$response" == "Data updated" ]; then
                echo "Data updated from $me."
            else
                echo "Data update failed."
            fi
        fi
    else
        echo "Data for hostname $hn does not exist. Inserting..."
        # Prepare the data for insertion
        DATA='{
            "hostname": "'"$hn"'",
            "cronjobsscripts": "'"$line"'"
        }'

        # Send a POST request to insert the data
        response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "http://192.168.1.169:3000/create/cronjobs")

        if [ "$response" == "Data inserted" ]; then
            echo "Data inserted from $me."
        else
            echo "Data insert failed."
        fi
    fi
done
