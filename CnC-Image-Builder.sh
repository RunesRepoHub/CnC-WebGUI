folder='CnC-WebGUI/CnC-WebGUI'
USERNAME=$(whoami)
version=$(cat /$USERNAME/CnC-WebGUI/Version.txt)

touch /$USERNAME/$folder/.env
echo "version=$version" > /$USERNAME/$folder/.env


docker build -t cnc-web:$version /$USERNAME/CnC-WebGUI/CnC-WebGUI/Nginx-Docker
docker build -t cnc-mysql:$version /$USERNAME/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

docker compose -f /$USERNAME/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p cnc-webgui up -d
