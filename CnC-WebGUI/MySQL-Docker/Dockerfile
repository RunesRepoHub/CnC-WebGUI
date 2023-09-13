FROM mysql:5.7 
ENV MYSQL_DATABASE machines
ENV MYSQL_ROOT_HOST='%'
COPY ./scripts/ /docker-entrypoint-initdb.d/