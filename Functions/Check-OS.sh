#!/bin/bash

##### Styles ######
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
BrownOrange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m'
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'
White='\e[1;37m'
NC='\e[0m'  # Reset to default
###################

# Install needed tools for installation script to work
echo "${Purple}Move to root directory${NC}"
cd
echo "${Yellow}Install sudo, Git, jq${NC}"
apt-get install sudo >/dev/null 2>&1
apt-get install git -y >/dev/null 2>&1
apt-get install jq -y >/dev/null 2>&1


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

user=$(id -u -n)


## Check if OS is Debian 10 
if [[ $OS == "Debian GNU/Linux" && $VER == "10" ]]; then
    
    ## Run Debian Installer
    bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/Run-Install-Debian.sh)


## Check if OS is Debian 10     
elif [[ $OS == "Debian GNU/Linux" && $VER == "11" ]]; then
    
    ## Run Debian Installer
    bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/Run-Install-Debian.sh)


## Check if OS is Ubuntu 22.04 and root user
elif [[ $OS == "Ubuntu" && $VER == "22.04" && $user == "root" ]]; then
    
    ## Run Debian Installer
    bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/Run-Install-Debian.sh)


## Check if OS is Ubuntu 22.04 and "normal user"
elif [[ $OS == "Ubuntu" && $VER == "22.04" && $user != "root" ]]; then
    
    ## Run Ubuntu Installer
    bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/Run-Install-Debian.sh)


else
echo "Unsupported OS"
fi
