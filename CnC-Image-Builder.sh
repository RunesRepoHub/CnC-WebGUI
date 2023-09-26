version=$(cat ~/CnC-WebGUI/Version.txt)

touch ~/CnC-WebGUI/CnC-WebGUI/.env
echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env


docker build -t cnc-web:$version ~/CnC-WebGUI/CnC-WebGUI/Nginx-Docker
docker build -t cnc-mysql:$version ~/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
