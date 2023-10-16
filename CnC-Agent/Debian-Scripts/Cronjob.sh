#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
hn=$(echo $HOSTNAME)
me=$(basename "$0")

# Capture the user's crontab and save it to a file
crontab -l > "$crontxt"

# Fetch the list of scripts from the database
database_scripts=$(curl -s "http://$databaseip:3000/read/cronjobs" | jq -r '.[] | .cronjobsscripts')

# Process each line of the crontab
while IFS= read -r line; do
    # Extract the script name from the line (assuming script names do not contain spaces)
    script_name=$(basename "$line")

    # Check if the script name is in the list of database scripts
    if ! echo "$database_scripts" | grep -q "$script_name"; then
        # Script not found in the database, create a new entry
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$script_name\"}" "http://$databaseip:3000/create/cronjobs"
    fi
done < "$crontxt"

#################################################################################################################################

#████████╗███████╗░██████╗████████╗
#╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
#░░░██║░░░█████╗░░╚█████╗░░░░██║░░░
#░░░██║░░░██╔══╝░░░╚═══██╗░░░██║░░░
#░░░██║░░░███████╗██████╔╝░░░██║░░░
#░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░


# Define the file where you want to save the date and time
output_file="date_time.txt"

# Use the date command to get the current date and time
current_datetime=$(date)

# Append the date and time to the file
echo "$current_datetime" >> "$output_file"

# Optionally, you can also print the date and time to the terminal
echo "Current date and time: $current_datetime"

# Exit the script
exit 0