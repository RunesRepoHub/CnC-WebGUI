#!/bin/bash
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)
me=$(basename "$0")

touch ~/CnC-WebGUI/CnC-Agent/cron.txt
crontab -l > ~/CnC-WebGUI/CnC-Agent/cron.txt

START=1
END=$(wc -l < ~/CnC-WebGUI/CnC-Agent/cron.txt)

# Define job names and variables
job_names=("Overview" "Packages" "Cronjob")
declare -A job_data

# Loop through the job names and retrieve data
for i in "${!job_names[@]}"; do
    job_name=${job_names[$i]}
    job_data[$job_name]=$(crontab -l | grep -i "$job_name" | sed -n '1 p')
    
    VAR1="$hn"
    VAR2="${job_data[$job_name]}"

    if [ -n "$VAR2" ]; then
        curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$VAR2\"}" "http://$databaseip:3000/create/cronjobs"
    fi
done