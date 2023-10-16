#!/bin/bash

# Version tag
Version="1.2"

# Global Variables
dbip="/root/CnC-WebGUI/CnC-Agent/.databaseip"

# Getting-started.sh
CnC_Image_Builder="/root/CnC-WebGUI/Functions/CnC-Image-Builder.sh"
Install_Agent="/root/CnC-WebGUI/CnC-Agent/Install-Agent.sh"
Uninstall=""

# Cronjob.sh 
crontxt="/root/CnC-WebGUI/CnC-Agent/cron.txt"

# Debian-Installer.sh 
pack_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh"
over_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh"
cron_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh"


# Install-Agent.sh
deb_ins="/root/CnC-WebGUI/CnC-Agent/Debian-Installer.sh"

# Check-OS.sh
deb_url_ins="https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/Run-Install-Debian.sh"

# CnC-Image-Builder.sh
ver_path="/root/CnC-WebGUI/CnC-WebGUI/.env"
web_path="/root/CnC-WebGUI/CnC-WebGUI/React-Docker"
pg_path="/root/CnC-WebGUI/CnC-WebGUI/Postgress-Docker"
apt_path="/root/CnC-WebGUI/CnC-WebGUI/Nodejs-Docker"
compose="/root/CnC-WebGUI/CnC-WebGUI/docker-compose.yaml"

# Run-Install-Debian.sh
get_start="/root/CnC-WebGUI/Functions/Getting-started.sh"