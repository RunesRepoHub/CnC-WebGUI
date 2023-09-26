me=$(basename "$0")
USERNAME=$(whoami)
export DEBIAN_FRONTEND=noninteractive

folder='/$USERNAME/CnC-WebGUI/CnC-Agent/Debian-Scripts'

filename='/$USERNAME/CnC-WebGUI/Logs/Debian-Installer.log'

## Update and install gnupg
clear
echo "Installing CnC-Agent"
apt update > /dev/null 2>&1 >> $filename
apt install gnupg -y > /dev/null 2>&1 >> $filename
apt install nmap -y > /dev/null 2>&1 >> $filename

## Download MySQL
clear
echo "Installing MySQL"
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp > /dev/null 2>&1 >> $filename
dpkg -i /tmp/mysql-apt-config_0.8.22-1_all.deb > /dev/null 2>&1 >> $filename
apt update > /dev/null 2>&1 >> $filename

## Install and set up MySQL
clear 
echo "Setting Up MySQL"

debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password 12Marvel" > /dev/null 2>&1 >> $filename
debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password 12Marvel" > /dev/null 2>&1 >> $filename

apt-get -y install mysql-server > /dev/null 2>&1 >> $filename
apt-get update > /dev/null 2>&1 >> $filename

systemctl stop mysql > /dev/null 2>&1 >> $filename
systemctl disable mysql > /dev/null 2>&1 >> $filename

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
    touch $folder/.databaseip
    echo "$databaseip" > $folder/.databaseip

    ## Check/Setup Packages Reporting via cron 
    ln -s $folder/Packages.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file >/dev/null 2>&1; echo '00 00 * * * ruby '$folder'/Packages.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash $folder/Packages.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s $folder/Overview.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby '$folder'/Overview.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash $folder/Overview.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s $folder/Cronjob.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby '$folder'/Cronjob.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash $folder/Cronjob.sh

    rm file
else 
    echo "No Access To MySQL Server";
fi

