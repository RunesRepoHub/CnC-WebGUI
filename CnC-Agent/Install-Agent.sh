if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi


## Check if OS is Debian 10 
if [[ $OS == "Debian GNU/Linux" && $VER == "10" ]];
then
    ## Update the OS
    echo "Running apt-get update"
    apt-get update > /dev/null 2>&1

    ## Install Git to use git clone 
    echo "Installing git"
    apt-get install git -y > /dev/null 2>&1

    ## Git clone the files from the github repo
    git clone https://github.com/rune004/CnC-WebGUI.git ~/
    
    ## Run Debian Installer
    bash ~/CnC-WebGUI/CnC-Agent/Installers/Debian-Installer.sh
elif
    if [[ $OS == "Debian GNU/Linux" && $VER == "11" ]];
    then
    ## Update the OS
    echo "Running apt-get update"
    apt-get update > /dev/null 2>&1

    ## Install Git to use git clone 
    echo "Installing git"
    apt-get install git -y > /dev/null 2>&1

    ## Git clone the files from the github repo
    git clone https://github.com/rune004/CnC-WebGUI.git ~/
    
    ## Run Debian Installer
    bash ~/CnC-WebGUI/CnC-Agent/Installers/Debian-Installer.sh
    fi
else
    ## Check if OS is Ubuntu 22.04 
    if [[ $OS == "Ubuntu" && $VER == "22.04" ]];
    then
    ## Run Debian Installer
    ## Update the OS
    echo "Running apt-get update"
    apt-get update > /dev/null 2>&1

    ## Install Git to use git clone 
    echo "Installing git"
    apt-get install git -y > /dev/null 2>&1

    ## Git clone the files from the github repo
    git clone https://github.com/rune004/CnC-WebGUI.git ~/
    else
    ## If it is not a Ubuntu 22.04.
    echo "Unsupported OS"
    fi
fi

