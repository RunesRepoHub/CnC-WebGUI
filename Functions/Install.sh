#!/bin/bash
#########################################
#             RPH - rune004             #
#  Install.sh for Debian based systems  #
#      https://github.com/rune004       #
#########################################
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
echo -e "${Purple}Move to root directory${NC}"
cd
echo -e "${Yellow}Install sudo, Git, jq${NC}"
apt-get install sudo >/dev/null 2>&1
apt-get install git -y >/dev/null 2>&1
apt-get install jq -y >/dev/null 2>&1
echo -e "${Yellow}Install updates and Upgrade${NC}"
apt-get updates >/dev/null 2>&1
apt-get upgrade -y >/dev/null 2>&1

# Disclaimer
echo -e "${Blue}---------------------------------------------------------------${NC}"
echo -e "${Red}The Development Version is undergoing constant updates and changes to the code${NC} ${Yellow}and will therefor not always work as it should...${NC} ${Red}THIS HAS BEEN YOUR WARNING${NC}"
echo -e "${Blue}--------------------------------------------------------------${NC}" 
echo -e "${Green}The Production Version will only see massive update and changes to the code${NC}" 
echo -e "${Green}When it has been tested and vaildated on:${NC}"
echo
echo -e " ${Cyan}*${NC} ${Green}Debian 9,10,11${NC}"
echo
echo -e " ${Cyan}*${NC} ${Green}Ubuntu 20.04,22.04${NC}" 
echo -e "${Blue}---------------------------------------------------------------${NC}"
echo -e "${Red}This "software" is in "early access" so the will be a high likelyness of data loss when updating I will try my best to avoid it, but this is a headsup and warning to backup before updating${NC}"
echo
echo -e "${LightRed}Use this at your own risk, I am not a programmer so there might be some oversights, when it comes to security and scalability.${NC}"
echo -e "${Blue}---------------------------------------------------------------${NC}"


# Function to prompt the user to select a mode
select_mode() {
    while true; do
        read -p "Select a mode (Development/Production): " mode
        case "$mode" in
            "Development")
                echo "You selected Development mode."
                softwaremode="Dev"
                touch "/root/.softwaremode"
                echo "$softwaremode" > "/root/.softwaremode"
                export softwaremode
                return
                ;;
            "Production")
                echo "You selected Production mode."
                softwaremode="Production"
                touch "/root/.softwaremode"
                echo "$softwaremode" > "/root/.softwaremode"
                export softwaremode
                return
                ;;
            *)
                echo "Invalid choice. Please select either 'Development' or 'Production'."
                ;;
        esac
    done
}

# Call the select_mode function
select_mode


bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/$softwaremode/Functions/docker-install-script.sh)


user=$(id -u -n)

rm /root/.softwaremode

if [ -f ~/CnC-WebGUI/.serverinstallcon ] && [ -f ~/CnC-Agent/.clientinstallcon ]; then
    echo -e "${Green}Both Agent and Server was installed successful${NC}"
    echo -e "${Green}Go to https://runesrepohub.github.io/CnC-WebGUI/ for more information${NC}"
    echo -e "${Green}Go to https://github.com/RunesRepoHub/CnC-WebGUI/issues to report an issue with the WebGUI and https://github.com/RunesRepoHub/CnC-Agent/issues for the Agent${NC}"
elif  [ -f ~/CnC-WebGUI/.serverinstallcon ]; then
    echo -e "${Green}The Server was installed successful${NC}"
    echo -e "${Green}Go to https://runesrepohub.github.io/CnC-WebGUI/ for more information${NC}"
    echo -e "${Green}Go to https://github.com/RunesRepoHub/CnC-WebGUI/issues to report an issue with the WebGUI and https://github.com/RunesRepoHub/CnC-Agent/issues for the Agent${NC}"
elif  [ -f ~/CnC-Agent/.clientinstallcon ]; then
    echo -e "${Green}The Agent was installed successful${NC}"
    echo -e "${Green}Go to https://runesrepohub.github.io/CnC-WebGUI/ for more information${NC}"
    echo -e "${Green}Go to https://github.com/RunesRepoHub/CnC-WebGUI/issues to report an issue with the WebGUI and https://github.com/RunesRepoHub/CnC-Agent/issues for the Agent${NC}"
else
    echo -e "${Red}Installation has failed${NC}"
    echo -e "${Green}Go to https://runesrepohub.github.io/CnC-WebGUI/ for more information${NC}"
    echo -e "${Green}Go to https://github.com/RunesRepoHub/CnC-WebGUI/issues to report an issue with the WebGUI and https://github.com/RunesRepoHub/CnC-Agent/issues for the Agent${NC}"
fi