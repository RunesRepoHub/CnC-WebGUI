read -p "Version Tag Web: " versionweb
read -p "Version Tag DB: " versiondb
read -p "Registry IP+Port: " registryip

PS3='Please enter your choice: '
options=("Local" "Registry" "Dockerhub")
select opt in "${options[@]}"
do
    case $opt in
        "Local")
           docker build -t cnc-web:$versionweb /root/Development/CnC-WebGUI/CnC-WebGUI/Nginx-Docker

           docker build -t cnc-mysql:$versiondb /root/Development/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

           docker-compose -f /root/Development/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p CnC-WebGUI down -v 

           docker-compose -f /root/Development/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p CnC-WebGUI up -d

           exit
            ;;
        "Registry")
           registry="$registryip"

           docker build -t cnc-web:$versionweb /root/Development/CnC-WebGUI/CnC-WebGUI/Nginx-Docker

           docker tag cnc-web:$versionweb $registry/cnc-web:$versionweb

           docker push $registry/cnc-web:$versionweb


           docker build -t cnc-mysql:$versiondb /root/Development/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

           docker tag cnc-mysql:$versiondb $registry/cnc-mysql:$versiondb

           docker push $registry/cnc-mysql:$versiondb


           docker-compose -f /root/Development/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p CnC-WebGUI down -v 

           docker-compose -f /root/Development/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p CnC-WebGUI up -d

           exit
            ;;
        "Dockerhub")
            echo "Not Added Yet"
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done