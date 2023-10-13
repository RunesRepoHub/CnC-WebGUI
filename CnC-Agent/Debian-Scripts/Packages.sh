#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

databaseip=$(cat "$dbip")
me=$(basename "$0")

HOSTNAME=$(echo $HOSTNAME)

# Fetch existing data from the API
existing_data=$(curl -s "http://$databaseip:3000/read/packages/$HOSTNAME")

# Check if data already exists
if [ -n "$existing_data" ]; then
  echo "Data for hostname $HOSTNAME exists. Updating..."
  # Extract existing data and compare with new data
  existing_git=$(echo "$existing_data" | jq -r .git)
  existing_wget=$(echo "$existing_data" | jq -r .wget)
  # Add more variables for other fields as needed

  # Compare existing data with new data
  if [ "$existing_git" != "Installed" ]; then
    git_status="Not Installed"
  else
    git_status="Installed"
  fi

  if [ "$existing_wget" != "Installed" ]; then
    wget_status="Not Installed"
  else
    wget_status="Installed"
  fi
  # Add more comparisons for other fields as needed

  # Prepare the data for update
  DATA=$(cat <<EOF
{
    "hostname": "$HOSTNAME",
    "git": "$git_status",
    "wget": "$wget_status",
    # Add more fields here
}
EOF
)

  # Send a PUT request to update the data
  response=$(curl -X PUT -H "Content-Type: application/json" -d "$DATA" "http://$databaseip:3000/update/packages/$HOSTNAME")

  if [ "$response" == "Data updated" ]; then
    echo "Data updated from $me."
  else
    echo "Data update failed."
  fi
else
  echo "Data for HOSTNAME $HOSTNAME does not exist. Inserting..."

  # Prepare the data for insertion
  DATA=$(cat <<EOF
{
    "hostname": "$HOSTNAME",
    "git": "Installed",
    "wget": "Installed",
    # Add more fields here
}
EOF
)

  # Send a POST request to insert the data
  response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "http://$databaseip:3000/create/packages")

  if [ "$response" == "Data inserted" ]; then
    echo "Data inserted from $me."
  else
    echo "Data insert failed."
  fi
fi
