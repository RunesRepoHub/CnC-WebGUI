version=$(cat ~/CnC-WebGUI/Functions/Version.txt)

touch ~/CnC-WebGUI/CnC-WebGUI/.env
echo "version=$version" > ~/CnC-WebGUI/CnC-WebGUI/.env

docker build -t cnc-web:$version ~/CnC-WebGUI/CnC-WebGUI/Nginx-Docker >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log
docker build -t cnc-mysql:$version ~/CnC-WebGUI/CnC-WebGUI/MySQL-Docker >> ~/CnC-WebGUI/Logs/CnC-Image-Builder.log

clear

docker compose -f ~/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
