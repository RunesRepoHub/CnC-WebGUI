GIT_Version=$(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Version.txt)
LOCAL_Version=$(cat ~/CnC-WebGUI/Version.txt)

if [ $GIT_Version >= $LOCAL_Version ]; then 
    
    bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh

else 

    echo "There is a newer version of CnC-WebGUI"
    echo "Do you want to update first?"

    read -p "Are you sure? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/CnC-WebGUI/Update.sh

    fi 
fi
