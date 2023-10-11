#!/bin/bash
apt-get install sudo
apt-get curl
apt-get update
apt-get upgrade -y
apt-get install git

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Check the Linux distribution and version
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [[ $ID == "debian" && ($VERSION_ID == "9" || $VERSION_ID == "10" || $VERSION_ID == "11") ]]; then
    install_docker_cli
    install_docker_compose
  elif [[ $ID == "ubuntu" && $VERSION_ID == "22.04" ]]; then
    install_docker_cli
    install_docker_compose
  else
    echo "Unsupported distribution or version."
    exit 1
  fi
else
  echo "Unable to determine the Linux distribution and version."
  exit 1
fi

echo "Docker CLI and Docker Compose installation completed."


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
    bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Server/Debian/Run-Install-Debian.sh)

## Check if OS is Debian 10     
elif [[ $OS == "Debian GNU/Linux" && $VER == "11" ]]; then
    
    ## Run Debian Installer
    bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Server/Debian/Run-Install-Debian.sh)

## Check if OS is Ubuntu 22.04 and root user
elif [[ $OS == "Ubuntu" && $VER == "22.04" && $user == "root" ]]; then
    
    ## Run Debian Installer
    bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Server/Debian/Run-Install-Debian.sh)

## Check if OS is Ubuntu 22.04 and "normal user"
elif [[ $OS == "Ubuntu" && $VER == "22.04" && $user != "root" ]]; then
    
    ## Run Ubuntu Installer
    bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Server/Ubuntu/Run-Install-Ubuntu.sh)

else
echo "Unsupported OS"
fi
