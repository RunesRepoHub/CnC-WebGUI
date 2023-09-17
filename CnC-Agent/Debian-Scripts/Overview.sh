databaseip=$(cat ~/CnC-WebGUI/CnC-Agent/.databaseip)

hn=$(echo $HOSTNAME)

ip=$(hostname -I | awk '{print $1}')

mac_address=$(cat /sys/class/net/*/address | sed -n '1 p')

packages=$(apt-get -s --no-download dist-upgrade -V --fix-missing | grep '=>')

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

mysql --host=$databaseip --port=3306 --user=root --password=12Marvel machines << EOF
insert into info (hostname,ip_address,mac_address,disto,packages) values('$hn','$ip','$mac_address','$OS $VERSION','$packages');
EOF