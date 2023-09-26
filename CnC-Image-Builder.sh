GIT_Version=$("`wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Version.txt`")
LOCAL_Version=$(cat ~/CnC-WebGUI/Version.txt)

if [ $GIT_Version >= $LOCAL_Version ]; then

    version=$(cat ~/CnC-WebGUI/Version.txt)

    touch ~/CnC-WebGUI/CnC-WebGUI/.env
    echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env


    docker build -t cnc-web:$version ~/CnC-WebGUI/CnC-WebGUI/Nginx-Docker
    docker build -t cnc-mysql:$version ~/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
else 

    echo "There is a newer version of CnC-WebGUI"
    echo "Do you want to update first?"

    read -p "Are you sure? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/CnC-WebGUI/Download-Agent.sh

    fi 
fi