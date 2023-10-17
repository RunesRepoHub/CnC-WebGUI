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

# Function to remove a cron job
remove_cron_job() {
    local script_name="$1"
    crontab -l | grep -v "5 * * * * bash $script_name" | crontab -
}

# Remove the specified cron jobs
remove_cron_job "$pack_cron"
remove_cron_job "$over_cron"
remove_cron_job "$cron_cron"

echo "Cron jobs removed from your crontab."

# Remove both repos
rm -rf ~/CnC-WebGUI
rm -rf ~/CnC-Agent