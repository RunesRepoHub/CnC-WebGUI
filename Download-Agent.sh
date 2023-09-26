rm -r CnC-WebGUI/
USERNAME=$(whoami)
folder="/'$USERNAME'/CnC-WebGUI/CnC-Agent"

git clone --branch Production https://git.rp-helpdesk.com/Rune/CnC-WebGUI.git

bash $folder/Install-Agent.sh

