softwaremode=$(cat "/root/CnC-WebGUI/.softwaremode")
FILE=~/CnC-WebGUI
if [ -d "$FILE" ]; then
    ## Clear screen for better overview
    
    ## Inform the user if the file has already been downloaded
    echo -e "${Red}$FILE exists.${NC}"
    echo -e "${Red}Do you want to delete the old files and install a new version?${NC}"
    echo
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
        git clone --branch $softwaremode https://github.com/RunesRepoHub/CnC-WebGUI.git;
        ## Runs the installation script
        bash ~/CnC-WebGUI/Functions/Getting-started.sh;
    else
        bash ~/CnC-WebGUI/Functions/Getting-started.sh;
    fi
else 
    ## If the files has not been download before
    echo -e "${Green}$FILE does not exist.${NC}"
    ## Clones new files
    git clone --branch $softwaremode https://github.com/RunesRepoHub/CnC-WebGUI.git;
    ## Runs the installation script
    bash ~/CnC-WebGUI/Functions/Getting-started.sh;
fi 