me=$(basename "$0")
export DEBIAN_FRONTEND=noninteractive
## Update and install gnupg
clear
echo "Installing CnC-Agent"
apt update > /dev/null 2>&1
apt install gnupg -y > /dev/null 2>&1
apt install nmap -y > /dev/null 2>&1

## Download MySQL
clear
echo "Installing MySQL"
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp > /dev/null 2>&1
dpkg -i /tmp/mysql-apt-config_0.8.22-1_all.deb > /dev/null 2>&1
apt update > /dev/null 2>&1

## Install and set up MySQL
clear 
echo "Setting Up MySQL"

debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password 12Marvel" > /dev/null 2>&1
debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password 12Marvel" > /dev/null 2>&1

apt-get -y install mysql-server > /dev/null 2>&1

systemctl stop mysql > /dev/null 2>&1
systemctl disable mysql > /dev/null 2>&1


## Get database IP address
clear 
read -p "Database IP: " databaseip

mysqlup=$(nmap -p 3306 $databaseip)

if [ $mysqlup == "Host is up" ]; then
    ## Save database IP address
    touch ~/CnC-WebGUI/CnC-Agent/.databaseip
    echo "$databaseip" > ~/CnC-WebGUI/CnC-Agent/.databaseip

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file >/dev/null 2>&1; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview-test.sh

    ## Check/Setup Packages Reporting via cron 
    ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob-test.sh /usr/bin/ > /dev/null 2>&1

    crontab -l > file; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob-test.sh >/dev/null 2>&1' >> file; crontab file

    ## Run Packages Reporting for the first time
    bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob-test.sh
else 
    echo "No Access To MySQL Server";
    exit;
fi

