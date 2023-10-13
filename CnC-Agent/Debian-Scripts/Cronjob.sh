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

# Extract the "cronjobsscripts" field from the existing data
existing_cronjobs=$(echo "$existing_data" | jq -r '.cronjobsscripts')

# Process each line of the crontab
while IFS= read -r line; do
    # Check if the line exists in the existing cron jobs
    if [[ "$existing_cronjobs" != *"$line"* ]]; then
        # Line does not exist in existing cron jobs, so add it
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs" >/devnull 2>&1
    fi
done < "$crontxt"
