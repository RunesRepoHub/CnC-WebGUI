#!/bin/bash

##### Styles ######
Black='\003[0;30'     
DarkGray='\003[1;30'
Red='\003[0;31'     
LightRed='\003[1;31'
Green='\003[0;32'     
LightGreen='\003[1;32'
BrownOrange='\003[0;33'     
Yellow='\003[1;33'
Blue='\003[0;34'     
LightBlue='\003[1;34'
Purple='\003[0;35'     
LightPurple='\003[1;35'
Cyan='\003[0;36'     
LightCyan='\003[1;36'
LightGray='\003[0;37'     
White='\003[1;37'
NC='\033[0m'
###################


bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/Functions/docker-install-script.sh)
echo
echo
echo "---------------------------------------------------------------"
printf "The ${RED}Development Version${NC} is undergoing constant updates and changes to the code and will therefor not always work as it should... ${RED}THIS HAS BEEN YOUR WARNING${NC}\n"
echo "--------------------------------------------------------------" 
printf "The ${GREEN}Production Version${NC} will only see massive update and changes to the code\n" 
echo "When it has been tested and vaildated on:"
echo
echo " * Debian 9,10,11"
echo
echo " * Ubuntu 20.04,22.04" 
echo "---------------------------------------------------------------"
echo 'This "software" is in "early access" so the will be a high likelyness of data loss when updating I will try me best to avoid it, but this is a headsup and warning to backup before updating'
echo


PS3="Select the what version you want to install:"

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
                echo "Do you want to delete the old files and install a new version?"
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
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            ## Wrong input
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done
echo "Installation was successful"

echo 