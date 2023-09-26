PATH='CnC-WebGUI/CnC-WebGUI'
USERNAME=$(whoami)
version=$(cat /$USERNAME/CnC-WebGUI/Version.txt)

touch /$USERNAME/$PATH/.env
echo "version=$version" > /$USERNAME/$PATH/.env


docker build -t cnc-web:$version /$USERNAME/$PATH/Nginx-Docker
docker build -t cnc-mysql:$version /$USERNAME/$PATH/MySQL-Docker

docker compose -f /$USERNAME/$PATH/docker-compose.yaml -p cnc-webgui up -d
