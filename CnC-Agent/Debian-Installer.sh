source ~/CnC-WebGUI/config.sh
me=$(basename "$0")
export DEBIAN_FRONTEND=noninteractive

## Get database IP address
clear 
read -p "Database IP: " databaseip

# IP address and port to check
ip_address="$databaseip"
port="3306"

# Check if the port is open
if nc -z -w 2 "$ip_address" "$port"; then
    result="up"
else
    result="down"
fi

if [[ $result == "up" ]]; then
    ## Save database IP address
    touch "$dbip"
    echo "$databaseip" > "$dbip"

    ## Check/Setup Packages Reporting via cron 
    ln -s "$pack_cron" /usr/bin/ > /dev/null 2>&1

    # Define the cron job command using the sourced path
    cron_job_command1="00 00 * * * ruby "$pack_cron" >/dev/null 2>&1"
    
    # Set up the cron job
    { crontab -l; echo "$cron_job_command1"; } | crontab -

    ## Run Packages Reporting for the first time
    bash "$pack_cron"

    ## Check/Setup Packages Reporting via cron 
    ln -s "$over_cron" /usr/bin/ > /dev/null 2>&1

    # Define the cron job command using the sourced path
    cron_job_command2="00 00 * * * ruby "$over_cron" >/dev/null 2>&1"
    
    # Set up the cron job
    { crontab -l; echo "$cron_job_command2"; } | crontab -

    ## Run Packages Reporting for the first time
    bash "$over_cron"

    ## Check/Setup Packages Reporting via cron 
    ln -s "$cron_cron" /usr/bin/ > /dev/null 2>&1

    # Define the cron job command using the sourced path
    cron_job_command3="00 00 * * * ruby "$cron_cron" >/dev/null 2>&1"
    
    # Set up the cron job
    { crontab -l; echo "$cron_job_command3"; } | crontab -

    ## Run Packages Reporting for the first time
    bash "$cron_cron"

else 
    echo "No Access To MySQL Server";
fi

