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
            1) 
                bash "$CnC_Image_Builder"
                break
                ;;
            2) 
                FILE=~/CnC-Agent
                if [ -d "$FILE" ]; then
                    # Clear screen for better overview

                    # Inform the user if the file has already been downloaded
                    echo "$FILE exists."
                    echo "Do you want to delete the old files and install a new version?"
                    echo

                    # Ask the user for action input
                    read -p "Are you sure? " -n 1 -r
                    echo # Move to a new line

                    # Check user input
                    if [[ $REPLY =~ ^[Yy]$ ]]; then
                        # Remove old files
                        rm -rf ~/CnC-Agent

                        # Clones new files
                        echo
                        echo
                        git clone --branch Dev https://github.com/RunesRepoHub/CnC-Agent.git

                        # Runs the installation script
                        bash ~/CnC-Agent/Install-Agent.sh
                    else
                        bash ~/CnC-Agent/Install-Agent.sh
                    fi
                else
                    # If the files have not been downloaded before
                    echo "$FILE does not exist."

                    # Clones new files
                    echo
                    echo
                    git clone --branch Dev https://github.com/RunesRepoHub/CnC-Agent.git

                    # Runs the installation script
                    wget -O ~/CnC-Agent/config.sh "$get_config_url" > /dev/null 2>&1
                    bash "$Install_Agent"
                fi
                break
                ;;
            3) 
                bash "$Uninstall"
                break
                ;;
            $(( ${#items[@]} + 1)) )
                echo "We're done!"
                break
                ;;
            * ) echo "Oops - unknown choice $REPLY"
                break
                ;;
        esac
    done
done

echo
