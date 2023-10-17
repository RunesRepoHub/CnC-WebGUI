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

# Define the cron job script paths
pack_cron="/root/CnC-Agent/Debian-Scripts/Packages.sh"
over_cron="/root/CnC-Agent/Debian-Scripts/Overview.sh"
cron_cron="/root/CnC-Agent/Debian-Scripts/Cronjob.sh"

# Use sed to remove the specific entries from /etc/crontab
sudo sed -i "/$pack_cron/d" /etc/crontab
sudo sed -i "/$over_cron/d" /etc/crontab
sudo sed -i "/$cron_cron/d" /etc/crontab


# Remove both repos
rm -rf ~/CnC-WebGUI
rm -rf ~/CnC-Agent