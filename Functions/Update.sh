GIT_Version=$(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Version.txt)
LOCAL_Version=$(cat ~/CnC-WebGUI/Functions/Version.txt)

if [ $GIT_Version > "$LOCAL_Version" ]; then 

    echo "Removing files from old Version and Downloading the newest Version"

    rm -r ~/CnC-WebGUI 

    cd ~/ 

    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git > /dev/null 2>&1

    rm ~/Update.sh
    rm ~/$LOCAL_Version

    echo "The latest Version has been download and installed"
else  
    echo "An Error was incountered"
    echo "Error code 11 (Version Control Failed)"
    echo "Submit a issue on via github"
    echo "https://github.com/rune004/CnC-WebGUI/issues" 
fi
