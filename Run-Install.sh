#!/bin/bash

PS3="Select the what version you want to install:"

items=("Develop" "Production")

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) 
            git clone --branch Dev https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git;
            bash ~/CnC-WebGUI/Functions/Install-Develop.sh; 
            break 2;;
            2) 
            git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git
            bash ~/CnC-WebGUI/Functions/Install-Production.sh; 
            break 2;;
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done