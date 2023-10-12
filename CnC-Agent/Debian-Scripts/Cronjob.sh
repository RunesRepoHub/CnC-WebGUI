#!/bin/bash
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > ~/CnC-WebGUI/CnC-Agent/cron.txt

# Process each line of the crontab
while IFS= read -r line; do
    # Send the cron job data to the database
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs"
done < ~/CnC-WebGUI/CnC-Agent/cron.txt
