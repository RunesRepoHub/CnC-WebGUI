#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Function to update variables from API response
update_variables() {
    local data="$1"
    ip_address=$(jq -r '.ip_address' <<< "$data")
    mac_address=$(jq -r '.mac_address' <<< "$data")
    distro=$(jq -r '.distro' <<< "$data")
    packages=$(jq -r '.packages' <<< "$data")
}

# Read data from the API and update variables
response=$(curl -s "http://192.168.1.169:3000/read/cronjobs/$hn")
if [[ $? -eq 0 ]]; then
    update_variables "$response"
else
    echo "Failed to fetch data from the API."
    exit 1
fi

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Process each line of the crontab
while IFS= read -r line; do
    # Send the cron job data to the database
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$line\"}" "http://$databaseip:3000/create/cronjobs" >/dev/null 2>&1
done < "$crontxt"
