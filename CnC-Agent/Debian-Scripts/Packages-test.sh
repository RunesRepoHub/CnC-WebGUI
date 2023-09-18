databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)

git=$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}')
wget=$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}')
sudo=$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}')
python=$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}')
python3=$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}')
nettools=$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}')
mysql=$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}')
libpython=$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}')
dockercecli=$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}')
dockercomposeplugin=$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}')
curl=$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}')
containerd=$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}')
hn=$(echo $HOSTNAME)


mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines 2>/dev/null << EOF
insert into packages (hostname,git,wget,sudo,python,python3,nettools,mysql,libpython,dockercecli,dockercomposeplugin,curl,containerd) values('$hn','$git','$wget','$sudo','$python','$python3','$nettools','$mysql','$libpython','$dockercecli','$dockercomposeplugin','$curl','$containerd');
EOF