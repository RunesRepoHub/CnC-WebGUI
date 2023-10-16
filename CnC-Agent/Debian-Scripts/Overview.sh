#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

me=$(basename "$0")
databaseip=$(cat "$dbip")

#!/bin/bash

# Collect system overview data (replace with your data collection commands).
ip=$(ifconfig | grep -oP 'inet \K[\d.]+')
mac=$(ifconfig | grep -oP 'ether \K[\w:]+')
hostname=$(hostname)
distro=$(lsb_release -ds)

# Send system overview data to the Node.js server.
curl -X POST -H "Content-Type: application/json" -d "{\"ip\": \"$ip\", \"mac\": \"$mac\", \"hostname\": \"$hostname\", \"distro\": \"$distro\", \"type\": \"overview\"}" http://$databaseip:3000/system-info/overview
