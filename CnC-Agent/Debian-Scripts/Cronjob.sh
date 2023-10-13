#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Process each line of the crontab
while IFS= read -r line; do
    # Check if data exists in the database
    check_data=$(curl -s "http://$databaseip:3000/read/cronjobs?hostname=$hn&cronjobsscripts=$line")

    if [ "$check_data" == "Data exists" ]; then
        # Data exists; update it
        curl -X PUT -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/update/cronjobs"
    else
        # Data doesn't exist; create new data
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs"
    fi
done < "$crontxt"
