#!/bin/bash
# Source the configuration script
source ~/CnC-WebGUI/config.sh

clear 
PS3="Select the what you want to install on this server:"

items=("Server" "Agent" "Uninstall CnC-WebGUI") 
while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) bash $func_dir; break;;
            2) bash $agen_dir; break 2;;
            3) bash $func_dir/Uninstall.sh; break 2;;
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done
