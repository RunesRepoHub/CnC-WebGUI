# CnC-WebGUI
**WebGUI for giving overview to my Linux servers**

**Docker containers made from scratch to collect data from the Linux server.**

**Testing**

## Video Demo

[See how to deploy the code](https://media.rp-helpdesk.com/view?m=CLXrOulOT)

## Wiki

[See my wiki for the code](https://wiki.rp-helpdesk.com)

### Requriements 

**OS**
Supported:

* Debian 10 (Tested) (Web/DB & Agent)
* Debian 11 (Tested) (Web/DB & Agent)
* Ubuntu 22.04 (Tested) (Web/DB & Agent)

>***This has been setup as root on fresh installs***

**Web/db Server**
* Git install on the web/db server
* Docker + Docker-compose installed on the web/db server

**Agent Devices**
* No packages requried now (May change in the future)

## Installation
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