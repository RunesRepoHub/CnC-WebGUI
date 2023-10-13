#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

ip_address=$(hostname -I | awk '{print $1}')
mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')
packages=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep  ^Inst | wc -l)
me=$(basename "$0")
databaseip=$(cat "$dbip")

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
# ... (other OS detection code)

distro="$OS $VER"
fi

hostname=$(echo $HOSTNAME)

tpdata='{"id": " ","hostname":"'$hostname'"}

# Define your REST API endpoints
INFO_ENDPOINT="http://$databaseip:3000/read/info/$hostname"
CREATE_INFO_ENDPOINT="http://$databaseip:3000/create/info"

# Fetch existing data from the API
existing_data=$(curl -s "$INFO_ENDPOINT")

if [ -n "$existing_data" ]; then
  echo "Data for hostname $hostname exists. Updating..."

  ip_address=$(hostname -I | awk '{print $1}')
  mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')
  packages=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep  ^Inst | wc -l)

  # Prepare the data for update
  DATA='{
      "hostname": "'"$hostname"'",
      "ipaddress": "'"$ip_address"'",
      "macaddress": "'"$mac_address"'",
      "packages": "'"$packages"'"
  }'

  # Send a PUT request to update the data
  response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "$INFO_ENDPOINT")

  if [ "$response" == "$DATA" ]; then
    echo "Data updated from $me."
  else
    echo "Data update failed."
  fi
else
  echo "Data for hostname $hostname does not exist. Inserting..."

  # Insert the data
  ip_address=$(hostname -I | awk '{print $1}')
  mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')
  packages=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep  ^Inst | wc -l)

  if [ -f /etc/os-release ]; then
      . /etc/os-release
      OS=$NAME
      VER=$VERSION_ID
  # ... (other OS detection code)

  distro="$OS $VER"
  fi

  DATA='{
      "hostname": "'"$hostname"'",
      "ipaddress": "'"$ip_address"'",
      "macaddress": "'"$mac_address"'",
      "distro": "'"$distro"'",
      "packages": "'"$packages"'"
  }'

  # Send a POST request to insert the data
  response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$CREATE_INFO_ENDPOINT")

  if [ "$response" == "$DATA" ]; then
    echo "Data inserted from $me."
  else
    echo "Data insert failed."
  fi
fi
