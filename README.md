# SRB2K Quick Start
A small Bash script for compiling and installing SRB2Kart on fresh installs of Ubuntu 18.04+.
May prove useful in getting a SRB2Kart server up and running on a *VPS* a bit faster.

## Prerequisites
 - Ubuntu 18.04 LTS and above.
 - Decent amount of free disk space for:
	 - Download of dependencies/updates for system.
	 - Base games assets.
 - (Optional) **srb2kart** user created with sudo permissions.
## Usage
Use **wget** to grab the script directly.

    wget https://raw.githubusercontent.com/TheOneGoofAli/srb2kquickstart/main/srb2kqs.sh
If you want to download & start the script in one go, use 

    bash <(wget -qO- https://raw.githubusercontent.com/TheOneGoofAli/srb2kquickstart/main/srb2kqs.sh)
