me=$(basename "$0")
export DEBIAN_FRONTEND=noninteractive

filename='~/CnC-WebGUI/Logs/Debian-Installer.log'

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
    touch ~/CnC-WebGUI/CnC-Agent/.databaseip
    echo "$databaseip" > ~/CnC-WebGUI/CnC-Agent/.databaseip

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file >/dev/null 2>&1; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh

    rm file

else 
    echo "No Access To MySQL Server";
fi

