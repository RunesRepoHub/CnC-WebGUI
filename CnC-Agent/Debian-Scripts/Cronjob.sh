#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Fetch existing data from the URL and strip any leading/trailing whitespaces
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn" | tr -d '[:space:]')

# Process each line of the crontab
while IFS= read -r line; do
    # Strip any leading/trailing whitespaces from the line
    line=$(echo "$line" | tr -d '[:space:]')

    # Check if the line exists in the existing data
    if [[ "$existing_data" != *"$line"* ]]; then
        # Line does not exist in existing data, so add it
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs" >/dev/null 2>&1
    fi
done < "$crontxt"
