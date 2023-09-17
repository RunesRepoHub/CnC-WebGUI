# Dialog input to get database IP
databaseip=$(\
  dialog --title "Database IP" \
         --backtitle "CnC-Agent Setup Database IP" \
         --inputbox "User:" 10 60 \
  3>&1 1>&2 2>&3 3>&- \
) ||exit

##
touch ~/CnC-WebGUI/CnC-Agent/.databaseip
echo "$databaseip" > ~/CnC-Agent/.databaseip

## Check/Setup Packages Reporting via cron 
ln -s ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh /usr/bin/ > /dev/null 2>&1

crontab -l > file; echo '00 00 * * * ruby ~/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages-test.sh >/dev/null 2>&1' >> file; crontab file

## Run Packages Reporting for the first time
bash ~/CnC-Agent/Debian-Scripts/Packages-test.sh