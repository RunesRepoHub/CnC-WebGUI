## Installation
![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black) ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white) ![Github Pages](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)

### Docker images
The images has not been made public yet, so if you want to use this right now. You will have to build the images yourself.

Run this one line command for a automated install.

```
bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Run-Install.sh)
```
This should make the two docker images and after they have been made it will use the docker-compose file to start the two dockers. When the two dockers are up and running, check the you don't have errors on the website.

> (The WebGUI will give php errors at startup because it is still waiting for the database to come online) When it has come online you can then install the Agent to the servers you want to moniter.

### Install Agent
Run the following commands on a Debian 10/11 server to install the agent.

The docker web and db containers has to be running.

```
bash <(wget -qO- https://git.rp-helpdesk.com/Rune/CnC-WebGUI/raw/branch/Dev/Functions/Run-Install.sh)
```