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
            2) git clone --branch Dev "$repo_url_ins"; 
            wget https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Dev/config.sh ~/CnC-Agent/config.sh;
            bash "$Install_Agent"; break 2;;  
            3) bash "$Uninstall"; break 2;;  
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Oops - unknown choice $REPLY"; break;
        esac
    done
done

echo 
echo