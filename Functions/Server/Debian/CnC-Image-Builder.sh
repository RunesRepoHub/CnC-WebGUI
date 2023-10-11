version=$(cat ~/CnC-WebGUI/Functions/Version.txt)
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')


docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui down

clear


touch ~/CnC-WebGUI/CnC-WebGUI/.env
echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env


docker network create -d bridge cncnetwork
docker build -t cnc-web:1.2 /root/Development/CnC-WebGUI/CnC-WebGUI/Nginx-Docke
docker build -t cnc-pg:1.2 /root/Development/CnC-WebGUI/CnC-WebGUI/Postgress-Docker
docker build -t cnc-node-api:1.2 /root/Development/CnC-WebGUI/CnC-WebGUI/Nodejs-Docker

clear


docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
echo " "
echo " "
echo "This server can be used by CnC-Agents via this IP Address: $ip_address"
echo " "
echo " "