#!/bin/bash
echo
echo
echo "---------------------------------------------------------------"
echo "The Development Version is undergoing constant updates and changes to the code and will therefor not always work as it should... THIS HAS BEEN YOUR WARNING"
echo "--------------------------------------------------------------" 
echo "The Production Version will only see massive update and changes to the code" 
echo "When it has been tested and vaildated on:"
echo
echo " * Debian 9,10,11"
echo
echo " * Ubuntu 20.04,22.04" 
echo "---------------------------------------------------------------"
echo 'This "software" is in "early access" so the will be a high likelyness of data loss when updating I will try me best to avoid it, but this is a headsup and warning to backup before updating'
echo

mkdir ~/CnC-Agent

# URL of the GitHub repository and the target directory
repo_url="https://github.com/RunesRepoHub/CnC-WebGUI.git"
directory_path="/CnC-Agent"

# Clone the repository
git clone "$repo_url" /tmp/CnC-WebGUI

# Check if the cloning was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository."
  exit 1
fi

# Change to the target directory
cd "/tmp/CnC-WebGUI/$directory_path"

# Check if the directory exists
if [ -d "$PWD" ]; then
  # Download all scripts from the directory
    wget -r -np -nH --cut-dirs=2 --no-parent --reject "index.html*" -e robots=off "https://github.com/RunesRepoHub/CnC-WebGUI.git/blob/Production/CnC-Agent/"

  
  # Optionally, you can move the downloaded files to a different location
  mv ./* ~/CnC-Agent/

  # Clean up temporary files
  rm -rf "/tmp/CnC-WebGUI"

  echo "Download completed."
else
  echo "Error: The specified directory does not exist in the repository."
  exit 1
fi


bash ~/CnC-Agent/Install-Agent.sh;

echo "---------------------------------------------------------------"
echo 