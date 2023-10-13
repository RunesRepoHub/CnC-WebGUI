# Source the configuration script
source ~/CnC-WebGUI/config.sh

version=$(cat "$ver_path" | awk '{ print substr( $0, 9 ) }')
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')

echo
echo
echo

docker_network_ls=$(docker network ls | grep -i cnc-webgui_cncnetwork)

if [ "$docker_network_ls" == "cnc-webgui_cncnetwork" ]; then

docker build -t cnc-web:$version "$web_path"
docker build -t cnc-pg:$version "$pg_path"
docker build -t cnc-node-api:$version "$apt_path"

else 

docker network create -d bridge cnc-webgui_cncnetwork
docker build -t cnc-web:$version "$web_path"
docker build -t cnc-pg:$version "$pg_path"
docker build -t cnc-node-api:$version "$apt_path"

fi

docker compose -f "$compose" -p cnc-webgui down
docker compose -f "$compose" -p cnc-webgui up -d

echo " "
echo " "
echo "This server can be used by CnC-Agents via this IP Address: $ip_address"
echo " "
echo "And the WebGUI, can be accessed via $ip_address:8080"
echo
echo