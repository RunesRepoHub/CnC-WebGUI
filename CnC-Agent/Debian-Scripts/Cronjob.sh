#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

# Define your database IP, hostname, and other variables
databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Define the URL to fetch data from
data_url="http://192.168.1.169:3000/read/cronjobs/$hn"

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Fetch the data from the URL
data=$(curl -s "$data_url")

# Check if the data is not empty
if [ -n "$data" ]; then
    # Compare the data to the hostname
    if [ "$data" = "$hn" ]; then
        # Process each line of the crontab
        while IFS= read -r line; do
            # Send the cron job data to the database
            curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/update/cronjobs/$hn" >/dev/null 2>&1
        done < "$crontxt"
    else
        echo "Hostname does not match data from the URL."
    fi
else
    echo "Failed to fetch data from the URL: $data_url"
fi
