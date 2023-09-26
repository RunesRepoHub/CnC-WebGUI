folder='CnC-WebGUI/CnC-WebGUI'
USERNAME=$(whoami)
version=$(cat /$USERNAME/CnC-WebGUI/Version.txt)

touch /$USERNAME/$folder/.env
echo "version=$version" > /$USERNAME/$folder/.env


docker build -t cnc-web:$version /$USERNAME/$folder/Nginx-Docker
docker build -t cnc-mysql:$version /$USERNAME/$folder/MySQL-Docker

docker compose -f /$USERNAME/$folder/docker-compose.yaml -p cnc-webgui up -d
