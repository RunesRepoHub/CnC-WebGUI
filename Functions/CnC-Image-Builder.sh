version=$(cat ~/CnC-WebGUI/Functions/Version.txt)
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')



touch ~/CnC-WebGUI/CnC-WebGUI/.env
echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env

docker build -t cnc-web:$version ~/CnC-WebGUI/CnC-WebGUI/Nginx-Docker >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log
docker build -t cnc-mysql:$version ~/CnC-WebGUI/CnC-WebGUI/MySQL-Docker >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log

clear

if [[ $dockerdb="cnc-mysql:$version" && $dockerweb="cnc-web:$version" ]]; then

    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
    echo " "
    echo " "

    echo "This server can be used by CnC-Agents via this IP Address: $ip_address"

    echo " "
    echo " "

else
    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui down
    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
    echo " "
    echo " "

    echo "This server can be used by CnC-Agents via this IP Address: $ip_address"

    echo " "
    echo " "

fi 