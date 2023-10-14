#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a temporary file
crontab -l > "$crontxt"

# Fetch existing data from the URL
existing_data=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn")

# Extract the "cronjobsscripts" field from the existing data
existing_cronjobs=$(echo "$existing_data" | jq -r '.cronjobsscripts')

# Save the existing cron jobs to a temporary file
echo "$existing_cronjobs" > "$existing_cronjobs_file"

# Use 'diff' to compare the crontab with existing data
if [ -s "$crontxt" ] && ! diff -q "$crontxt" "$existing_cronjobs_file" >/dev/null; then
    echo "Updating cron jobs..."
    
    # Update the database with the new crontab
    update_response=$(curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$(cat "$crontxt")\"}" "http://$databaseip:3000/update/cronjobs/$id")
    
    if [ "$update_response" = "Data update failed." ]; then
        echo "Error: Data update failed."
    else
        echo "Cron jobs updated successfully."
    fi
else
    echo "Cron jobs are up to date. No changes required."
fi

# Clean up the temporary files
rm -f "$existing_cronjobs_file" "$crontxt"
