# Source the configuration script
source ~/CnC-WebGUI/config.sh
version=$(cat "$ver_path" | awk '{ print substr( $0, 9 ) }')

# Shutdown the dockers 
docker compose -f "$compose" -p cnc-webgui down

# Remove the docker images used by the dockers 
docker rmi cnc-web:$version
docker rmi cnc-pg:$version
docker rmi cnc-node-api:$version

# Remove docker volume used by the dockers
docker volume rm cnc-webgui_dbdata

sudo sed -i '/Packages\.sh\|Cronjob\.sh\|Overview\.sh/d' /etc/crontab

# Remove both repos
rm -rf ~/CnC-WebGUI
rm -rf ~/CnC-Agent