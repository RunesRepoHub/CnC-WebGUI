#!/bin/bash

PS3="Select the what version you want to install:"

items=("Develop" "Production")

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) 
            FILE=~/CnC-WebGUI/Functions/Install-Develop.sh
            if [ -f "$FILE" ]; then
                echo "$FILE exists. Do you want to delete the old files and install a new version?"
                read -p "Are you sure? " -n 1 -r
                echo    # (optional) move to a new line
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                    # do dangerous stuff
                    rm -r ~/CnC-WebGUI
                    git clone --branch Dev https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git;
                    bash ~/CnC-WebGUI/Functions/Install-Develop.sh;
                   
                fi
            else 
                echo "$FILE does not exist."
                git clone --branch Dev https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git;
                bash ~/CnC-WebGUI/Functions/Install-Develop.sh;
            fi 
            break 2;;
            2) 

            FILE=~/CnC-WebGUI/Functions/Install-Production.sh
            if [ -f "$FILE" ]; then
                echo "$FILE exists. Do you want to delete the old files and install a new version?"
                read -p "Are you sure? " -n 1 -r
                echo    # (optional) move to a new line
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                    # do dangerous stuff
                    rm -r ~/CnC-WebGUI
                    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git
                    bash ~/CnC-WebGUI/Functions/Install-Production.sh;
                   
                fi
            else 
                echo "$FILE does not exist."
                git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git
                bash ~/CnC-WebGUI/Functions/Install-Production.sh;
            fi 
            break 2;;
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done