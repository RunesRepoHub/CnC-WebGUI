#!/bin/bash
databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)

job1=$(crontab -l | sed -n '1 p')

# MySQL database connection details
DB_HOST="$databaseip"
DB_PORT="3306"
DB_USER="root"
DB_PASSWORD="12Marvel"
DB_NAME="machines"
START=1
END=20
## save $START, just in case if we need it later ##
i=$START
while [[ $i -le $END ]]
do
    job1=$(crontab -l | sed -n '1 p')

    # Data to insert if it doesn't exist in the database
    VAR1="$hn"
    VAR2="$job1"

    # Check if the data already exists in the database
    existing_data=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS>

    # If no rows were returned, insert the data
    if [ -z "$existing_data" ]; then
    echo "Inserting data into the database..."
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NA>
    echo "Data inserted successfully."
    else
    echo "Data already exists in the database."
    fi
   ((i = i + 1))
done
