#!/bin/bash

# Source the configuration script
source /root/CnC-WebGUI/config.sh

clear
PS3="Select what you want to install on this server:"

items=("Server" "Agent" "Uninstall CnC-WebGUI")
while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1) eval "$CnC_Image_Builder"; break;;  # Use `eval` to execute the command in the variable.
            2) eval "$Install_Agent"; break 2;;  # Use `eval` to execute the command in the variable.
            3) eval "$Uninstall"; break 2;;  # Use `eval` to execute the command in the variable.
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            *) echo "Oops - unknown choice $REPLY"; break;
        esac
    done
done