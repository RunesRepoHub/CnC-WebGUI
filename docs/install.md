# CnC-WebGUI Installation

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)


## Setup

* You have to be root user.
* Make sure to change the hostname before running this.
* Make sure to run.
    1. apt-get update
    2. apt-get upgrade


## Install 

### Docker images
The images has not been made public yet, so if you want to use this right now. You will have to build the images yourself.

Run this one line command for a automated install.

This command will install docker, docker cli and docker compose, and when docker has been installed or updated, then the installation script will start running.

```
bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-WebGUI/Production/Functions/Check-OS.sh)
```
This should make the 3 docker images and after they have been made it will use the docker-compose file to start the 3 dockers. When the 3 dockers are up and running, check the you don't have errors on the website.

> (The WebGUI will give php errors at startup because it is still waiting for the database to come online) When it has come online you can then install the Agent to the servers you want to moniter.

### Install Agent
Run the following commands on a Debian 9/10/11/12 or Ubuntu 20.04/22.04 server to install the agent.

The docker web, api and db containers has to be running.

```
bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/CnC-Agent/Production/Install-Agent-Only.sh)
```

## Uninstall 

I have made it easy to Uninstall aswell.

### WebGUI Server

How to uninstall the dockers and delete all their data on the Web Server?

Use this one line command to call on a Uninstall.sh script the will do the rest:
```
bash ~/CnC-WebGUI/Functions/Uninstall.sh  
```

### Agents

How to uninstall the Agents and delete all their data on the Server?

Use this one line command to call on a Uninstall.sh script the will do the rest:
```
bash ~/CnC-Agent/Uninstall.sh  
```
