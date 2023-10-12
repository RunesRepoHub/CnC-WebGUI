databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
me=$(basename "$0")


# Escape double quotes in variables
HOSTNAME=$(echo "$HOSTNAME" | sed 's/"/\\"/g')
GIT=$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}' | sed 's/"/\\"/g')
WGET=$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}' | sed 's/"/\\"/g')
SUDO=$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}' | sed 's/"/\\"/g')
PYTHON=$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}' | sed 's/"/\\"/g')
PYTHON3=$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}' | sed 's/"/\\"/g')
NETTOOLS=$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}' | sed 's/"/\\"/g')
MYSQL=$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}' | sed 's/"/\\"/g')
LIBPYTHON=$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}' | sed 's/"/\\"/g')
DOCKERCECLI=$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}' | sed 's/"/\\"/g')
DOCKERCOMPOSEPLUGIN=$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}' | sed 's/"/\\"/g')
CURL=$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}' | sed 's/"/\\"/g')
CONTAINERD=$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}' | sed 's/"/\\"/g')

# Set default values for variables if they are empty or unset
[ -z "$HOSTNAME" ] && HOSTNAME="Not Installed"
[ -z "$GIT" ] && GIT="Not Installed"
[ -z "$WGET" ] && WGET="Not Installed"
[ -z "$SUDO" ] && SUDO="Not Installed"
[ -z "$PYTHON" ] && PYTHON="Not Installed"
[ -z "$PYTHON3" ] && PYTHON3="Not Installed"
[ -z "$NETTOOLS" ] && NETTOOLS="Not Installed"
[ -z "$MYSQL" ] && MYSQL="Not Installed"
[ -z "$LIBPYTHON" ] && LIBPYTHON="Not Installed"
[ -z "$DOCKERCECLI" ] && DOCKERCECLI="Not Installed"
[ -z "$DOCKERCOMPOSEPLUGIN" ] && DOCKERCOMPOSEPLUGIN="Not Installed"
[ -z "$CURL" ] && CURL="Not Installed"
[ -z "$CONTAINERD" ] && CONTAINERD="Not Installed"


# Define your REST API endpoint for updating/inserting data
API_ENDPOINT="http://$databaseip:3000/create/packages"

# Define the data to be sent to the API
DATA=$(cat <<EOF
{
    "hostname": "'"$HOSTNAME"'",
    "git": "'"$GIT"'",
    "wget": "'"$SUDO"'",
    "sudo": "'"$PYTHON"'",
    "python": "'"$PYTHON3"'"
    "python3": "'"$PYTHON3"'"
    "nettools": "'"$NETTOOLS"'"
    "mysql": "'"$MYSQL"'"
    "libpython": "'"$LIBPYTHON"'"
    "dockercecli": "'"$DOCKERCECLI"'"
    "dockercomposeplugin": "'"$DOCKERCOMPOSEPLUGIN"'"
    "curl": "'"$CURL"'"
    "containerd": "'"$CONTAINERD"'"
}
EOF
)

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