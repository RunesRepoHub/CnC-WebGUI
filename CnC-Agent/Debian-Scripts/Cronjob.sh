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

# Save the existing cron jobs to a temporary file
echo "$existing_cronjobs" > "$existing_cronjobs_file"

# Use 'diff' to compare the crontab with existing data
if diff -q "$crontxt" "$existing_cronjobs_file" >/dev/null; then
    echo "Cron jobs are up to date. No changes required."
else
    echo "Updating cron jobs..."
    
    # Update the database with the new crontab
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$(cat "$crontxt")\"}" "http://$databaseip:3000/update/cronjobs/$id" >/dev/null 2>&1
fi

# Clean up the temporary file
rm -f "$existing_cronjobs_file"
