databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)
hn=$(echo $HOSTNAME)

olddata=$(mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
SELECT * FROM cronjobs WHERE hostname LIKE "$hn"
EOF)

for data in "${olddata[@]}" ; do
    if [ $olddata == "$data" ]; then
    
    break;
    
    else 
    
        for insert in "${olddata[@]}" ; do
        
        job1=$(crontab -l | sed -n '1 p')
        
        mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
        insert into cronjobs (hostname,cron_jobs_scripts) values('$hn','$job1');
        EOF
    

    done

done

