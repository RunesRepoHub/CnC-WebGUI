rm -r CnC-WebGUI/
USERNAME=$(whoami)
folder="CnC-WebGUI/CnC-Agent"

git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git

bash /$USERNAME/$folder/Install-Agent.sh

