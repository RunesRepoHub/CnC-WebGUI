GIT_Version=$(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Version.txt)
LOCAL_Version=$(cat ~/CnC-WebGUI/Version.txt)

if [ $GIT_Version > "$LOCAL_Version" ]; then 

    rm -r ~/CnC-WebGUI >> ~/CnC-WebGUI/Logs/Update.log

    cd ~/ >> ~/CnC-WebGUI/Logs/Update.log

    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git >> ~/CnC-WebGUI/Logs/Update.log

    rm ~/Update.sh >> ~/CnC-WebGUI/Logs/Update.log

    echo "The latest Version has been download and installed"
else  
    echo "An Error was incountered"
    echo "Error code 11 (Version Control Failed)"
    echo "Submit a issue on via github"
    echo "https://github.com/rune004/CnC-WebGUI/issues" 
fi
