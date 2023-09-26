#!/bin/bash

PS3="Select the what you want to install on this server:"

items=("Agent" "Server" "Quit")

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh; break;;
            2) bash ~/CnC-WebGUI/Functions/CnC-Image-Builder.sh; break;;
            3) break;;
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done