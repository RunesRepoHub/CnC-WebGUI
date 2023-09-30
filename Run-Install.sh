#!/bin/bash

PS3="Select the what version you want to install:"

items=("Develop" "Production")

## Select Version of code to download

while true; do
    select item in "${items[@]}" Quit
    do
        case $REPLY in
            1)
            ## Check if this version has been downloaded before 
            FILE=~/CnC-WebGUI
            if [ -f "$FILE" ]; then
                ## Clear screen for better overview
                clear
                ## Inform the user if the file has already been downloaded
                echo "$FILE exists. Do you want to delete the old files and install a new version?"
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
                    git clone --branch Dev https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git;
                    ## Runs the installation script
                    bash ~/CnC-WebGUI/Functions/Install-Develop.sh;
                fi
            else 
                ## If the files has not been download before
                echo "$FILE does not exist."
                ## Clones new files
                git clone --branch Dev https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git;
                ## Runs the installation script
                bash ~/CnC-WebGUI/Functions/Install-Develop.sh;
            fi 
            break 2;;
            2) 
            ## Check if this version has been downloaded before
            FILE=~/CnC-WebGUI
            if [ -f "$FILE" ]; then
                ## Clear screen for better overview
                clear
                ## Inform the user if the file has already been downloaded
                echo "$FILE exists. Do you want to delete the old files and install a new version?"
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
                    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git
                    ## Runs the installation script
                    bash ~/CnC-WebGUI/Functions/Install-Production.sh;
                fi
            else 
                ## If the files has not been download before
                echo "$FILE does not exist."
                ## Clones new files
                git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git
                ## Runs the installation script
                bash ~/CnC-WebGUI/Functions/Install-Production.sh;
            fi 
            break 2;;
            ## When quiting the script
            $((${#items[@]}+1))) echo "We're done!"; break 2;;
            ## Wrong input
            *) echo "Ooops - unknown choice $REPLY"; break;
        esac
    done
done