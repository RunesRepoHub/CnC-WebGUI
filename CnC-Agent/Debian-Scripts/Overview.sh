#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

me=$(basename "$0")
databaseip=$(cat "$dbip")

# Set the hostname variable
hostname=$(echo $HOSTNAME)

# Define the URL for reading data
READ_API_ENDPOINT="http://192.168.1.169:3000/read/info/$hostname"
id=$(curl http://192.168.1.169:3000/read/info/$hostname | jq -r .id)


# Fetch existing data from the API
existing_data=$(curl -s "$READ_API_ENDPOINT")

if [ -n "$existing_data" ]; then
  echo "Data for hostname $hostname exists. Updating..."
  # Extract existing data and compare with new data
  existing_ip_address=$(echo "$existing_data" | jq -r .ipaddress)
  existing_mac_address=$(echo "$existing_data" | jq -r .macaddress)
  existing_distro=$(echo "$existing_data" | jq -r .distro)
  existing_packages=$(echo "$existing_data" | jq -r .packages)

  # Compare existing data with new data
  if [ "$existing_ip_address" != "$ip_address" ]; then
    ip_address="$existing_ip_address"
  fi

  if [ "$existing_mac_address" != "$mac_address" ]; then
    mac_address="$existing_mac_address"
  fi

  if [ "$existing_distro" != "$distro" ]; then
    distro="$existing_distro"
  fi

  if [ "$existing_packages" != "$packages" ]; then
    packages="$existing_packages"
  fi

  # Prepare the data for update
  DATA='{
      "hostname": "'"$hostname"'",
      "ipaddress": "'"$ip_address"'",
      "macaddress": "'"$mac_address"'",
      "distro": "'"$distro"'",
      "packages": "'"$packages"'"
  }'

  # Send a PUT request to update the data
  UPDATE_API_ENDPOINT="http://192.168.1.169:3000/update/info/$id"
  response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "$UPDATE_API_ENDPOINT")

  if [ "$response" == "Data updated" ]; then
    echo "Data updated from $me."
  else
    echo "Data update failed."
  fi
else
  echo "Data for hostname $hostname does not exist. Inserting..."

  # Prepare the data for insertion
  DATA='{
      "hostname": "'"$hostname"'",
      "ipaddress": "'"$ip_address"'",
      "macaddress": "'"$mac_address"'",
      "distro": "'"$distro"'",
      "packages": "'"$packages"'"
  }'

  # Send a POST request to insert the data
  CREATE_API_ENDPOINT="http://192.168.1.169:3000/create/info"
  response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$CREATE_API_ENDPOINT")

  if [ "$response" == "Data inserted" ]; then
    echo "Data inserted from $me."
  else
    echo "Data insert failed."
  fi
fi
