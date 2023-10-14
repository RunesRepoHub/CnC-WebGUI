#!/bin/bash
# Source the configuration script
# Default configuration
config_file="~/CnC-Agent/config.sh"

# Check if CnC-WebGUI config exists
if [ -f "~/CnC-WebGUI/config.sh" ]; then
    config_file="~/CnC-WebGUI/config.sh"
fi

# Source the configuration script
source "$config_file"



databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Process each line of the crontab
while IFS= read -r line; do
    # Send the cron job data to the database
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs"
done < "$crontxt"
