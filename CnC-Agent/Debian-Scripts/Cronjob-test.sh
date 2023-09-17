databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)
job1=$(crontab -l | sed -n '1 p')
job2=$(crontab -l | sed -n '2 p')
job3=$(crontab -l | sed -n '3 p')
job4=$(crontab -l | sed -n '4 p')
job5=$(crontab -l | sed -n '5 p')
job6=$(crontab -l | sed -n '6 p')
job7=$(crontab -l | sed -n '7 p')
job8=$(crontab -l | sed -n '8 p')
job9=$(crontab -l | sed -n '9 p')
job10=$(crontab -l | sed -n '10 p')
job11=$(crontab -l | sed -n '11 p')
job12=$(crontab -l | sed -n '12 p')
job13=$(crontab -l | sed -n '13 p')
job14=$(crontab -l | sed -n '14 p')
job15=$(crontab -l | sed -n '15 p')
job16=$(crontab -l | sed -n '16 p')
job17=$(crontab -l | sed -n '17 p')
job18=$(crontab -l | sed -n '18 p')
job19=$(crontab -l | sed -n '19 p')
job20=$(crontab -l | sed -n '20 p')
job21=$(crontab -l | sed -n '21 p')
job22=$(crontab -l | sed -n '22 p')
job23=$(crontab -l | sed -n '23 p')
job24=$(crontab -l | sed -n '24 p')
job25=$(crontab -l | sed -n '25 p')
job26=$(crontab -l | sed -n '26 p')
job27=$(crontab -l | sed -n '27 p')
job28=$(crontab -l | sed -n '28 p')
job29=$(crontab -l | sed -n '29 p')
job30=$(crontab -l | sed -n '30 p')

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job1');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job2');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job3');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job4');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job5');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job6');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job7');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job8');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job9');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job10');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job11');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job12');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job13');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job14');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job15');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job16');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job17');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job18');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job19');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job20');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job21');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job22');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job23');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job24');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job25');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job26');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job27');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job28');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job29');
EOF > /dev/null 2>&1

pause 2

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into cronjobs (hostname,cronjobs) values('$hn','$job30');
EOF > /dev/null 2>&1