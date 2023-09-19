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
    VAR1="docker-ce-cli"
    VAR2="$dockercecli"
    elif [ $i == 10 ]; then
    VAR1="docker-compose-plugin"
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

# Function to update data in the database
update_data() {
    local hostname="$hostname"
    local package="$VAR1"
    local package_version="$VAR2"

    # Update the data in the database
    mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" 2>/dev/null <<EOF
    UPDATE packages
    SET package_version='$package_version'
    WHERE hostname='$hostname' AND package='$VAR1' AND package_version='$VAR2';
EOF
}

    # Check if the data exists in the database
    result=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -N -e "SELECT hostname FROM packages WHERE hostname='$hostname' AND package='$VAR1' AND package_version='$VAR2';" 2>/dev/null)


    # If data exists, update it; otherwise, insert a new record
if [ -n "$result" ]; then
    update_data "$hostname" "$VAR1" "$VAR2"
    echo "Data updated from $me."
else
    # Insert new data into the database
    mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" 2>/dev/null <<EOF
    INSERT INTO info (hostname, package, package_version)
    VALUES ('$hostname', '$package', '$package_version');
EOF
    echo "Data inserted from $me."
fi

((i = i + 1))
done