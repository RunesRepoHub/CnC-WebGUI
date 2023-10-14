# Getting Started With CnC-WebGUI

This is still an internal tools and has not been made available to the public yet. It is also still under development and is not yet production ready.

### Basic Operation Procedures (BOP)

* Collect CPU, RAM and Disk usage.
* Collect data on docker version and other SOP (standard operation procedure) software version.
* Uptimer and warning.
 

### Advanced Operation Procedures (AOP)
* ~~Change basic configs~~
* ~~Reboot/shutdown/update/upgrade~~
* Overview of cron jobs
* ~~Change and update cron jobs~~
* Tailscale VPN
* Docker images sync vulnerability scan


## Development
Management interface

* This will be built based on a homemade docker stack, which includes Nginx for WebGUI and MySQL for database.

* CnC WebGUI Managed will be made in HTML, Php, CSS and Javascript. CnC Monitor Agent will be made in bash, with either cron or systemctl as run-timer.


## Remote Management

* It will also be possible to deploy with Tailscale VPN, so that a connection can be established between servers that are not on the same local network.

* It may also be possible to use another program, but I have not tested other than Tailscale with automatic deployment.


## Easy Deployment
The idea behind this whole system is to have a better and faster overview of all my Linux servers, but without adding a maintenance problem with more new "Pre-made" software.

So I make a bash script that sets up a Linux server to a CnC WebGUI Manager, as a Docker container and then I make another bash script to install the CnC Monitor Agent, which sends the data from the Linux servers to the CnC WebGUI Manager.

It will most likely be added 2 separate bash scripts containing Tailscale VPN for Remote Management.