#!/bin/bash

databaseip=$(cat "$dbip")
me=$(basename "$0")

#!/bin/bash

packages=$(dpkg --get-selections | awk '{print $1}')

curl -X POST -H "Content-Type: application/json" -d '{"type": "packages", "packageName": "'"$packages"'"}' http://$databaseip:3000/system-info