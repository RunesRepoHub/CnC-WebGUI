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

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Check if lsb_release command is available (Ubuntu/Debian)
if [ -x "$(command -v lsb_release)" ]; then
    DISTRO=$(lsb_release -is)
else
    # If lsb_release is not available, try to identify the distribution based on files
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi
fi

# Install Docker and Docker Compose on Ubuntu
install_docker_ubuntu() {
    apt-get update > /dev/null 2>&1
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1

    # Add Docker GPG key and repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null 2>&1
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    apt-get update > /dev/null 2>&1
    apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
}

# Install Docker and Docker Compose on Debian
install_docker_debian() {
    apt-get update > /dev/null 2>&1
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common > /dev/null 2>&1

    # Add Docker GPG key and repository
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null 2>&1
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

    apt-get update > /dev/null 2>&1
    apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
}

# Install Docker Compose
install_docker_compose() {
    if [ ! -f /usr/local/bin/docker-compose ]; then
        curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    fi
}

# Check if Docker is already installed
if [ -x "$(command -v docker)" ]; then
    echo -e "${Green}Docker is already installed.${NC}"
    echo -e "${Yellow}Updating Docker...${NC}"
    echo -e "${Yellow}This can take a while...${NC}"
    apt-get update > /dev/null 2>&1
    apt-get upgrade -y > /dev/null 2>&1
else
    echo -e "${Yellow}Docker is not installed. Installing...${NC}"
    echo -e "${Yellow}This can take a while...${NC}"
    case $DISTRO in
        "Ubuntu") install_docker_ubuntu ;;
        "Debian") install_docker_debian ;;
        *) echo "Unsupported distribution. Exiting."; exit 1 ;;
    esac
fi

# Install Docker Compose
install_docker_compose

# Check Docker and Docker Compose versions
dockerv=$(docker --version)
dockercomposev=$(docker-compose --version)

echo -e "${Green}${dockerv}${NC}"
echo -e "${Green}${dockercomposev}${NC}"
echo -e "${Green}Docker and Docker Compose installation completed.${NC}"

exit 0
