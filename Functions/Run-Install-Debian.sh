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


bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/docker-install-script.sh)
echo
echo
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
echo -e "${Blue}---------------------------------------------------------------${NC}"
echo


PS3="${Purple}Select the what version you want to install:${NC}"

items=("Development" "Production")

## Select Version of code to download

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1)
            ## Check if this version has been downloaded before 
            FILE=~/CnC-WebGUI
            if [ -d "$FILE" ]; then
                ## Clear screen for better overview
                
                ## Inform the user if the file has already been downloaded
                echo "$FILE exists."
                echo -e "${Red}Do you want to delete the old files and install a new version?${NC}"
                echo
                ## Ask the user for action input
                read -p "Are you sure? " -n 1 -r
                ## Move to a new line
                echo
                ## Check user input    
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                    ## Remove old files
                    rm -r ~/CnC-WebGUI
                    ## Clones new files
                    echo
                    echo
                    git clone --branch Dev https://github.com/RunesRepoHub/CnC-WebGUI.git;
                    ## Runs the installation script
                    bash ~/CnC-WebGUI/Functions/Getting-started.sh;
                else
                    bash ~/CnC-WebGUI/Functions/Getting-started.sh;
                fi
            else 
                ## If the files has not been download before
                echo "$FILE does not exist."
                ## Clones new files
                echo
                echo
                git clone --branch Dev https://github.com/RunesRepoHub/CnC-WebGUI.git;
                ## Runs the installation script
                bash ~/CnC-WebGUI/Functions/Getting-started.sh;
            fi 
            break 2;;
            2) 
            ## Check if this version has been downloaded before
            FILE=~/CnC-WebGUI
            if [ -d "$FILE" ]; then
                ## Clear screen for better overview
                
                ## Inform the user if the file has already been downloaded
                echo "$FILE exists."
                echo "Do you want to delete the old files and install a new version?"
                ## Ask the user for action input
                read -p "Are you sure? " -n 1 -r
                ## Move to a new line
                echo 
                ## Check user input    
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                    ## Remove old files
                    rm -r ~/CnC-WebGUI
                    ## Clones new files
                    echo
                    echo
                    git clone --branch Production https://github.com/RunesRepoHub/CnC-WebGUI.git;
                    ## Runs the installation script
                    bash ~/CnC-WebGUI/Functions/Getting-started.sh;
                else
                    bash ~/CnC-WebGUI/Functions/Getting-started.sh;
                fi
            else 
                ## If the files has not been download before
                echo "$FILE does not exist."
                ## Clones new files
                echo
                echo
                git clone --branch Production https://github.com/RunesRepoHub/CnC-WebGUI.git;
                ## Runs the installation script
                bash ~/CnC-WebGUI/Functions/Getting-started.sh;
            fi 
            break 2;;
            ## When quiting the script
            $((${#items[@]}+1))) echo "Go to https://runesrepohub.github.io/CnC-WebGUI/ for more information"; break 2;;
            ## Wrong input
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done



githubversion="curl https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/CnC-WebGUI/.env"
localversion="cat ~/CnC-WebGUI/CnC-WebGUI/.env"

if [ "$localversion" == "$githubversion" ]; then
FILE1=~/CnC-WebGUI
FILE2=~/CnC-Agent

if [[ -d "$FILE1" && -d "$FILE2" ]]; then
    echo -e "${Green}Installation seems to have been successful${NC}"
else 
    echo -e "${Red}Installation seems to have failed${NC}"
    echo -e "${Red}Make sure you are trying to install into ~/ or /root/${NC}"
fi
else 
    echo -e "${Red}Installation seems to have failed${NC}"
    echo -e "${Red}Make sure you are trying to install into ~/ or /root/${NC}"
fi