

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into info (hostname,ip_address,mac_address,disto,packages) values('$hn','$ip','$mac_address','$OS $VERSION','$packages');
EOF