# Source the configuration script
source ~/CnC-WebGUI/config.sh
version=$(cat "$ver_path" | awk '{ print substr( $0, 9 ) }')

# Shutdown the dockers 
docker compose -f "$compose" -p cnc-webgui down

# Remove the docker network used by the dockers 
docker network rm cnc-webgui_cncnetwork

# Remove the docker images used by the dockers 
docker rm cnc-web:$version
docker rm cnc-pg:$version
docker rm cnc-node-api:$version

# Remove docker volume used by the dockers
docker volume rm cnc-webgui_dbdata

# Define the paths you want to search for in cron jobs
target_paths=("$pack_cron" "$over_cron" "$cron_cron")

# Get the current user's crontab
current_user=$(whoami)
crontab -l > /tmp/user_crontab

# Filter and remove cron jobs with the specified paths
filtered_crontab=""
while IFS= read -r line; do
    should_remove=0
    for path in "${target_paths[@]}"; do
        if [[ "$line" == *"$path"* ]]; then
            should_remove=1
            break
        fi
    done
    if [ "$should_remove" -eq 0 ]; then
        filtered_crontab+="$line"$'\n'
    fi
done < /tmp/user_crontab

# Install the updated crontab
echo "$filtered_crontab" | crontab -

# Clean up temporary files
rm /tmp/user_crontab

echo "Cron jobs with specified paths removed from your crontab."

# Remove both repos
rm -rf ~/CnC-WebGUI
rm -rf ~/CnC-Agent