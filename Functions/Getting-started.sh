#!/bin/bash

# Source the configuration script
source ~/CnC-WebGUI/config.sh

echo 
echo

PS3="Select what you want to install on this server:"

items=("Server" "Agent" "Uninstall CnC-WebGUI")
while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) bash "$CnC_Image_Builder"; break;;  
            2) 
            FILE=~/CnC-Agent
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
            if [[ $REPLY =~ ^[Yy]$ ]]; then
            ## Remove old files
            rm -rf ~/CnC-Agent
            ## Clones new files
            echo
            echo
            git clone --branch Dev https://github.com/RunesRepoHub/CnC-Agent.git;
            ## Runs the installation script
            else
            bash ~/CnC-Agent/Install-Agent.sh;
            fi
            else 
            ## If the files has not been download before
            echo "$FILE does not exist."
            ## Clones new files
            echo
            echo
            git clone --branch Dev https://github.com/RunesRepoHub/CnC-Agent.git;
            ## Runs the installation script
            wget -O ~/CnC-Agent/config.sh "$get_config_url" > /dev/null 2>&1;
            bash ~/CnC-Agent/Install-Agent.sh; 
            bash "$Install_Agent";
            fi; break 2;;  
            3) bash "$Uninstall"; break 2;;  
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Oops - unknown choice $REPLY"; break;
        esac
    done
done

echo 
echo