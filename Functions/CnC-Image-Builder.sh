# Source the configuration script
source /root/CnC-WebGUI/config.sh

version=$(cat "$ver_path" | awk '{ print substr( $0, 9 ) }')
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')


docker network create -d bridge cncnetwork
docker build -t cnc-web:$version "$web_path"
docker build -t cnc-pg:$version "$pg_path"
docker build -t cnc-node-api:$version "$apt_path"

clear

docker compose -f "$compose" -p cnc-webgui down
docker compose -f "$compose" -p cnc-webgui up -d

echo " "
echo " "
echo "This server can be used by CnC-Agents via this IP Address: $ip_address:8080"
echo " "
echo " "