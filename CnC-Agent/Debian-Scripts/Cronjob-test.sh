#!/bin/bash
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)
me=$(basename "$0")

touch ~/CnC-WebGUI/CnC-Agent/cron.txt
crontab -l > ~/CnC-WebGUI/CnC-Agent/cron.txt

# MySQL database connection details
DB_HOST="$databaseip"
DB_PORT="3306"
DB_USER="root"
DB_PASSWORD="12Marvel"
DB_NAME="machines"
START=1
END=$(wc -l < ~/CnC-WebGUI/CnC-Agent/cron.txt)
## save $START, just in case if we need it later ##
i=$START
while [[ $i -le $END ]]
do
    if [ $i == 1 ]; then
    job1=$(crontab -l | grep -i Overview | sed -n '1 p')
    
    elif [ $i == 2 ]; then
    job2=$(crontab -l | grep -i Packages-test | sed -n '1 p')
    
    elif [ $i == 3 ]; then
    job3=$(crontab -l | grep -i Cronjob-test | sed -n '1 p')

    else
        echo "" > /dev/null 2>&1
    fi
    # Data to insert if it doesn't exist in the database
    VAR1="$hn"
    if [ $i == 1 ]; then
    VAR2="$job1"
    elif [ $i == 2 ]; then
    VAR2="$job2"
    elif [ $i == 3 ]; then
    VAR2="$job3"
    else
        echo "" > /dev/null 2>&1
    fi

    # Check if the data already exists in the database
    existing_data=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT * FROM cronjobs WHERE hostname='$VAR1' AND cron_jobs_scripts='$VAR2';" 2>/dev/null)

    # If no rows were returned, insert the data
    if [ -z "$existing_data" ]; then
    echo "Inserting data into the database from $me..."
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "INSERT INTO cronjobs (hostname, cron_jobs_scripts) VALUES ('$VAR1', '$VAR2');" 2>/dev/null
    echo "Data inserted successfully from $me."
    else
    if [ $i == 1 ]; then
    echo "Data already exists in the database from $me."
    else
    echo "" > /dev/null 2>&1
    fi
    fi
    ((i = i + 1))
done
