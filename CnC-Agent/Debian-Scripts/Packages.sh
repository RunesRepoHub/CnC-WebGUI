databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
me=$(basename "$0")
hn=$(echo $HOSTNAME)


# MySQL database connection details
DB_HOST="$databaseip"
DB_PORT="3306"
DB_USER="root"
DB_PASSWORD="12Marvel"
DB_NAME="machines"
START=1
END=12
## save $START, just in case if we need it later ##
i=$START
while [[ $i -le $END ]]
do
    if [ $i == 1 ]; then
    git=$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}')

    elif [ $i == 2 ]; then
    wget=$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}')

    elif [ $i == 3 ]; then
    sudo=$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}')

    elif [ $i == 4 ]; then
    python=$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}')

    elif [ $i == 5 ]; then
    python3=$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}')

    elif [ $i == 6 ]; then
    nettools=$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}')

    elif [ $i == 7 ]; then
    mysql=$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}')

    elif [ $i == 8 ]; then
    libpython=$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}')

    elif [ $i == 9 ]; then
    dockercecli=$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}')

    elif [ $i == 10 ]; then
    dockercomposeplugin=$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}')

    elif [ $i == 11 ]; then
    curl=$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}')

    elif [ $i == 12 ]; then
    containerd=$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}')

    else 
        echo "" > /dev/null 2>&1
    fi

    if [ $i == 1 ]; then
    VAR1="git"
    VAR2="$git"
    elif [ $i == 2 ]; then
    VAR1="wget"
    VAR2="$wget"
    elif [ $i == 3 ]; then
    VAR1="sudo"
    VAR2="$sudo"
    elif [ $i == 4 ]; then
    VAR1="python"
    VAR2="$python"
    elif [ $i == 5 ]; then
    VAR1="python3"
    VAR2="$python3"
    elif [ $i == 6 ]; then
    VAR1="nettools"
    VAR2="$nettools"
    elif [ $i == 7 ]; then
    VAR1="mysql"
    VAR2="$mysql"
    elif [ $i == 8 ]; then
    VAR1="libpython"
    VAR2="$libpython"
    elif [ $i == 9 ]; then
    VAR1="dockercecli"
    VAR2="$dockercecli"
    elif [ $i == 10 ]; then
    VAR1="dockercomposeplugin"
    VAR2="$dockercomposeplugin"
    elif [ $i == 11 ]; then
    VAR1="curl"
    VAR2="$curl"
    elif [ $i == 12 ]; then
    VAR1="containerd"
    VAR2="$containerd"
    else
        echo "" > /dev/null 2>&1
    fi

    # Check if the data already exists in the database
    existing_data=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT * FROM packages WHERE '$VAR1'='$VAR1' AND '$VAR2'='$VAR2';" 2>/dev/null)

    # If no rows were returned, insert the data
    if [ -z "$existing_data" ]; then
    echo "Inserting data into the database from $me..."
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "INSERT INTO packages ('$VAR1', '$VAR2') VALUES ('$VAR1', '$VAR2');" 2>/dev/null
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