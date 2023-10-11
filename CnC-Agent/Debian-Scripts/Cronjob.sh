#!/bin/bash
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)
me=$(basename "$0")

touch ~/CnC-WebGUI/CnC-Agent/cron.txt
crontab -l > ~/CnC-WebGUI/CnC-Agent/cron.txt

START=1
END=$(wc -l < ~/CnC-WebGUI/CnC-Agent/cron.txt)
## save $START, just in case if we need it later ##
i=$START
while [[ $i -le $END ]]
do
    if [ $i == 1 ]; then
    job1=$(crontab -l | grep -i Overview | sed -n '1 p')
    
    elif [ $i == 2 ]; then
    job2=$(crontab -l | grep -i Packages | sed -n '1 p')
    
    elif [ $i == 3 ]; then
    job3=$(crontab -l | grep -i Cronjob | sed -n '1 p')

    else
        echo "" > /dev/null 2>&1
    fi
    # Data to insert if it doesn't exist in the database
    VAR1="$hn"
    if [ $i == 1 ]; then
    VAR2="$job1"
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$VAR2\"}" "http://$databaseip:3000/create/cronjobs"

    elif [ $i == 2 ]; then
    VAR2="$job2"
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$VAR2\"}" "http://$databaseip:3000/create/cronjobs"

    elif [ $i == 3 ]; then
    VAR2="$job3"
    curl -X POST -H "Content-Type: application/json" -d "{\"hostname\": \"$hn\", \"cronjobsscripts\": \"$VAR2\"}" "http://$databaseip:3000/create/cronjobs"

    else
        echo "" > /dev/null 2>&1
    fi

    ((i = i + 1))
done
