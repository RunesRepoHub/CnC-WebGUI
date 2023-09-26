#!/bin/bash

PS3="Select the what you want to install on this server:"

items=("Server" "Agent" "Uninstall CnC-WebGUI")

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) bash ~/CnC-WebGUI/Functions/CnC-Image-Builder.sh; break;;
            2) bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh; break 2;;
            3) bash ~/CnC-WebGUI/Functions/Uninstall.sh; break 2;;
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done