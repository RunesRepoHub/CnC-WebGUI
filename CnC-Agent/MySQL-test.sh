mysql --host=192.168.1.100 --port=3306 --user=root --password=12Marvel machines << EOF
insert into info (hostname,ip_address,mac_address,disto,packages) values('Iron Man','192.168.1.12','testmac4321','debian 10','tailscale + starship');
EOF