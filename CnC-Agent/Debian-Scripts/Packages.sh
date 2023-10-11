databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
me=$(basename "$0")


HOSTNAME=$(echo $HOSTNAME)
GIT=$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}')
WGET=$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}')
SUDO=$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}')
PYTHON=$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}')
PYTHON3=$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}')
NET_TOOLS=$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}')
MYSQL=$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}')
LIBPYTHON=$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}')
DOCKER_CE_CLI=$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}')
DOCKER_COMPOSE_PLUGIN=$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}')
CURL=$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}')
CONTAINERD=$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}')


# Define your REST API endpoint for querying and updating data
API_ENDPOINT="http://$databaseip:3000/create/packages"

# Define the data to be sent to the API
DATA='{
    "hostname": "'"$HOSTNAME"'",
    "git": "'"$GIT"'",
    "wget": "'"$WGET"'",
    "sudo": "'"$SUDO"'",
    "python": "'"$PYTHON"'",
    "python3": "'"$PYTHON3"'",
    "nettools": "'"$NETTOOLS"'",
    "mysql": "'"$MYSQL"'",
    "libpython": "'"$LIBPYTHON"'",
    "dockercecli": "'"$DOCKERCECLI"'",
    "dockercomposeplugin": "'"$DOCKERCOMPOSEPLUGIN"'",
    "curl": "'"$CURL"'",
    "containerd": "'"$CONTAINERD"'"
}'

# Debugging: Print the data being sent
echo "Sending data: $DATA"

# Send a POST request to the API to update or insert data
response=$(curl -X POST -H "Content-Type: application/json" -d "$DATA" "$API_ENDPOINT")

# Debugging: Print the response from the API
echo "API response: $response"

# Check the response from the API
if [ "$response" == "Data updated" ]; then
    echo "Data updated from $me."
else
    echo "Data inserted from $me."
fi

