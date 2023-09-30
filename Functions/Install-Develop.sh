GIT_Version=$(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Version.txt)
LOCAL_Version=$(cat ~/CnC-WebGUI/Functions/Version.txt)




if [ $GIT_Version == "$LOCAL_Version" ]; then

    bash ~/CnC-WebGUI/Functions/Getting-started.sh

elif [ $GIT_Version > "$LOCAL_Version" ] ; then 

    echo "There is a newer version of CnC-WebGUI"
    echo "Do you want to update first?"

    read -p "Are you sure? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        wget https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Update-Dev.sh -P ~/ > /dev/null 2>&1
        bash ~/CnC-WebGUI/Functions/Update-Dev.sh

        sleep 5

        bash ~/CnC-WebGUI/Functions/Getting-started.sh

    fi 
else 
    echo "An Error was incountered"
    echo "Error code 11 (Version Control Failed)"
    echo "Submit a issue on via github"
    echo "https://github.com/rune004/CnC-WebGUI/issues" 
fi
