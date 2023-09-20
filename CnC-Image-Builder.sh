docker build -t cnc-web:1.0 /root/CnC-WebGUI/CnC-WebGUI/Nginx-Docker
docker build -t cnc-mysql:1.0 /root/CnC-WebGUI/CnC-WebGUI/MySQL-Docker

docker compose -f /root/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml -p CnC-WebGUI up -d
