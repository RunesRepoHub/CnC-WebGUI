PATH='/CnC-WebGUI/CnC-Agent'
databaseip=$(cat $PATH/.databaseip)
me=$(basename "$0")


HOSTNAME=$(echo $HOSTNAME)
GIT=$(apt list --installed 2>/dev/null | grep -i git/ | awk '{print $2}')
WGET=$(apt list --installed 2>/dev/null | grep -i wget | awk '{print $2}')
SUDO=$(apt list --installed 2>/dev/null | grep -i sudo | awk '{print $2}')
PYTHON=$(apt list --installed 2>/dev/null | grep -i python/ | awk '{print $2}')
PYTHON3=$(apt list --installed 2>/dev/null | grep -i python3/ | awk '{print $2}')
NET_TOOLS=$(apt list --installed 2>/dev/null | grep -i net-tools | awk '{print $2}')
MYSQL=$(apt list --installed 2>/dev/null | grep -i mysql-server/ | awk '{print $2}')
LIBPYTHON=$(apt list --installed 2>/dev/null | grep -i libpython3.7/ | awk '{print $2}')
DOCKER_CE_CLI=$(apt list --installed 2>/dev/null | grep -i docker-ce-cli | awk '{print $2}')
DOCKER_COMPOSE_PLUGIN=$(apt list --installed 2>/dev/null | grep -i docker-compose-plugin | awk '{print $2}')
CURL=$(apt list --installed 2>/dev/null | grep -i curl/ | awk '{print $2}')
CONTAINERD=$(apt list --installed 2>/dev/null | grep -i containerd.io | awk '{print $2}')


# MySQL server credentials
DB_HOST="$databaseip"
DB_USER="root"
DB_PASS="12Marvel"
DB_NAME="machines"


# Query the MySQL database for existing data
existing_data=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM packages WHERE hostname='$HOSTNAME'" 2>/dev/null)

# Check if data for the current hostname already exists
if [ -n "$existing_data" ]; then
    # Update the existing record
    mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e 2>/dev/null "UPDATE packages SET
        git='$GIT',
        wget='$WGET',
        sudo='$SUDO',
        python='$PYTHON',
        python3='$PYTHON3',
        net_tools='$NET_TOOLS',
        mysql='$MYSQL',
        libpython='$LIBPYTHON',
        docker_ce_cli='$DOCKER_CE_CLI',
        docker_compose_plugin='$DOCKER_COMPOSE_PLUGIN',
        curl='$CURL',
        containerd='$CONTAINERD'
        WHERE hostname='$HOSTNAME'" 
else
    # Insert a new record
    mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e "INSERT INTO packages (
        hostname,
        git,
        wget,
        sudo,
        python,
        python3,
        net_tools,
        mysql,
        libpython,
        docker_ce_cli,
        docker_compose_plugin,
        curl,
        containerd
    ) VALUES (
        '$HOSTNAME',
        '$GIT',
        '$WGET',
        '$SUDO',
        '$PYTHON',
        '$PYTHON3',
        '$NET_TOOLS',
        '$MYSQL',
        '$LIBPYTHON',
        '$DOCKER_CE_CLI',
        '$DOCKER_COMPOSE_PLUGIN',
        '$CURL',
        '$CONTAINERD'
    )" 2>/dev/null
fi