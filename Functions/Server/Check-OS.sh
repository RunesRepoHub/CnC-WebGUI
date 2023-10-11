#!/bin/bash
apt-get install sudo
apt-get curl
apt-get update
apt-get upgrade -y
apt-get install git

# Function to install Docker CLI
install_docker_cli() {
  # Update the package list and install required packages
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

  # Add Docker GPG key and repository
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install Docker
  sudo apt update
  sudo apt install -y docker-ce

  # Start and enable the Docker service
  sudo systemctl start docker
  sudo systemctl enable docker

  # Add the current user to the "docker" group to run Docker without sudo
  sudo usermod -aG docker $USER

  # Output Docker version
  docker --version
}

# Function to install Docker Compose
install_docker_compose() {
  # Download the latest stable release of Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

  # Make Docker Compose executable
  sudo chmod +x /usr/local/bin/docker-compose

  # Output Docker Compose version
  docker-compose --version
}

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
