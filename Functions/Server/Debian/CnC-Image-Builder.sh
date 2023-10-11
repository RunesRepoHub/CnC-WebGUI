version=$(cat ~/CnC-WebGUI/Functions/Version.txt)
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')



touch ~/CnC-WebGUI/CnC-WebGUI/.env
echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env


docker network create -d bridge cncnetwork  >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log
docker build -t cnc-web:$version /root/Development/CnC-WebGUI/CnC-WebGUI/Nginx-Docker  >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log
docker build -t cnc-pg:$version /root/Development/CnC-WebGUI/CnC-WebGUI/Postgress-Docker  >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log
docker build -t cnc-node-api:$version /root/Development/CnC-WebGUI/CnC-WebGUI/Nodejs-Docker  >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log

clear

    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui down
    docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
    echo " "
    echo " "

    echo "This server can be used by CnC-Agents via this IP Address: $ip_address"

    echo " "
    echo " "