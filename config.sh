#!/bin/bash

# Global Variables
dbip="/root/CnC-WebGUI/CnC-Agent/.databaseip"

# Getting-started.sh
CnC_Image_Builder="bash ~/CnC-WebGUI/Functions/CnC-Image-Builder.sh"
Install_Agent="bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh"
Uninstall=""

# Cronjob.sh 
crontxt="/root/CnC-WebGUI/CnC-Agent/cron.txt"

# Debian-Installer.sh 
pack_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Packages.sh"
over_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Overview.sh"
cron_cron="/root/CnC-WebGUI/CnC-Agent/Debian-Scripts/Cronjob.sh"

# Install-Agent.sh
deb_ins="/root/CnC-WebGUI/CnC-Agent/Debian-Installer.sh"