#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Fetch existing data from the URL
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn")

# Create an array of existing cron job lines
IFS=$'\n' read -r -a existing_cronjobs <<< "$existing_data"

# Process each line of the crontab
while IFS= read -r line; do
    # Flag to check if line is already in existing_cronjobs
    line_exists=0

    # Check if the line exists in existing_cronjobs
    for existing_line in "${existing_cronjobs[@]}"; do
        if [[ "$line" == "$existing_line" ]]; then
            line_exists=1
            break
        fi
    done

    # If the line doesn't exist, add it to the database
    if [ $line_exists -eq 0 ]; then
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs" >/dev/null 2>&1
    fi
done < "$crontxt"
