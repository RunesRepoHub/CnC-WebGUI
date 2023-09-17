read -p "Database IP: " databaseip

##
touch ~/CnC-WebGUI/CnC-Agent/.databaseip
echo "$databaseip" > ~/CnC-WebGUI/CnC-Agent/.databaseip

## Check/Setup Packages Reporting via cron 
ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh /usr/bin/ > /dev/null 2>&1

crontab -l > file; echo '00 00 * * * ruby ~CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh >/dev/null 2>&1' >> file; crontab file

## Run Packages Reporting for the first time
bash ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh

