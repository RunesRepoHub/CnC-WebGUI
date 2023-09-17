#!/bin/bash

databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)

hostname=$(echo $HOSTNAME)


ip_address=$(hostname -I | awk '{print $1}')

mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')

packages=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep  ^Inst | wc -l)

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# MySQL server credentials
DB_HOST="$databaseip"
DB_USER="root"
DB_PASS="12Marvel"
DB_NAME="machines"

# Function to update data in the database
update_data() {
    local hostname="$hostname"
    local ip_address="$ip_address"
    local mac_address="$mac_address"
    local disto="$disto"
    local packages="$packages"
    
    # Update the data in the database
    mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
    UPDATE info
    SET packages='$packages'
    WHERE hostname='$hostname' AND ip_address='$ip_address' AND mac_address='$mac_address' AND disto='$disto';
EOF
}

# Check if the data exists in the database
result=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -N -e "SELECT hostname FROM info WHERE hostname='$hostname' AND ip_address='$ip_address' AND mac_address='$mac_address' AND disto='$disto';")

# If data exists, update it; otherwise, insert a new record
if [ -n "$result" ]; then
    update_data "$hostname" "$ip_address" "$mac_address" "$disto" "$packages"
    echo "Data updated."
else
    # Insert new data into the database
    mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
    INSERT INTO info (hostname, ip_address, mac_address, disto, packages)
    VALUES ('$hostname', '$ip_address', '$mac_address', '$disto', '$packages');
EOF
    echo "Data inserted."
fi