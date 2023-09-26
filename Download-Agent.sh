GIT_Version=$("`wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Version.txt`")
LOCAL_Version=$(cat ~/CnC-WebGUI/Version.txt)

if [ $GIT_Version == $LOCAL_Version ]; then 
    
    bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh

else 

    rm -r CnC-WebGUI/

    git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git

    bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh
fi
