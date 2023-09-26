GIT_Version=$(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Version.txt)
LOCAL_Version=$(cat ~/CnC-WebGUI/Version.txt)

if [ $GIT_Version == $LOCAL_Version ]; then 
    
    bash ~/CnC-WebGUI/CnC-WebGUI.sh

elif [ $GIT_Version > "$LOCAL_Version" ] ; then  

    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git

    bash ~/CnC-WebGUI/CnC-WebGUI.sh
else  
    echo "An Error was incountered"
    echo "Error code 11 (Version Control Failed)"
    echo "Submit a issue on via github"
    echo "https://github.com/rune004/CnC-WebGUI/issues" 
fi
