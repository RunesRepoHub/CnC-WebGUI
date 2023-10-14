#!/bin/bash

echo
echo
echo "---------------------------------------------------------------"
echo "The Development Version is undergoing constant updates and changes to the code and will therefore not always work as it should... THIS HAS BEEN YOUR WARNING"
echo "--------------------------------------------------------------"
echo "The Production Version will only see massive updates and changes to the code"
echo "When it has been tested and validated on:"
echo
echo " * Debian 9,10,11"
echo
echo " * Ubuntu 20.04,22.04"
echo "---------------------------------------------------------------"
echo 'This "software" is in "early access" so there will be a high likelihood of data loss when updating. I will try my best to avoid it, but this is a heads-up and warning to backup before updating'
echo

# Define the target directory
target_directory=~/CnC-Agent

# Check if the target directory exists and is empty
if [ -d "$target_directory" ] && [ -z "$(ls -A "$target_directory")" ]; then
  echo "The target directory $target_directory exists and is empty."
else
  echo "Creating the target directory $target_directory..."
  mkdir -p "$target_directory"
fi

# URL of the GitHub repository and the target directory
repo_url="https://github.com/RunesRepoHub/CnC-WebGUI.git"
directory_path="CnC-Agent"

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

  # Use 'cp' to copy files to the target directory
  cp -r ./* "$target_directory/"

  # Clean up temporary files
  rm -rf "/tmp/CnC-WebGUI"

  echo "Download completed."
else
  echo "Error: The specified directory does not exist in the repository."
  exit 1
fi

# Execute the Install-Agent script if it exists
if [ -f "/root/CnC-Agent/Installers/Installers/Debian-Installer.sh" ]; then
  bash /root/CnC-Agent/Installers/Installers/Debian-Installer.sh
else
  echo "Error: Install-Agent.sh not found in the CnC-Agent directory."
fi

echo "---------------------------------------------------------------"
