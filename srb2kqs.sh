# SRB2Kart Compile & Install Script by TheOneGoofAli.
# May be useful for setting up dedicated servers on VPS.

# Color codes to pretty up code.
color='\033[0;32m'
nc='\033[0m'
warn='\033[0;36m'

echo -e "${color}SRB2Kart Compile & Install Script by TheOneGoofAli.${nc}"

if id "srb2kart" &>/dev/null; then
    echo 'Current user is "srb2kart", proceeding.'
else
	echo 'Current user is NOT "srb2kart", continue anyway?'
    select yn in "Yes" "No"; do
		case $yn in
			Yes ) echo ""; break;;
			No ) exit;;
		esac
	done
fi
echo 'Do you want to delete the cloned SRB2Kart repository after compiling?'
select yn in "Yes" "No"; do
	case $yn in
		Yes ) cleanupexec=1; break;;
		No ) cleanupexec=0; break;;
	esac
done
echo -e "${color}Hang on tight, we are starting.${nc}"
echo -e "${color}Performing an update check for packages...${nc}"
sudo apt-get update
echo -e "${color}Installing dependencies needed for compiling SRB2Kart...${nc}"
sudo apt-get -y install build-essential git p7zip-full p7zip-rar nasm libpng-dev zlib1g-dev libsdl2-dev libsdl2-mixer-dev libgme-dev libopenmpt-dev libcurl4-openssl-dev
echo -e "${color}Cloning the most recent version of SRB2Kart...${nc}"
git clone https://git.do.srb2.org/KartKrew/Kart-Public.git
cd Kart-Public
cd src
echo -e "${color}Compiling, this may take a while.${nc}"
LIBGME_CFLAGS= LIBGME_LDFLAGS=-lgme make
cd ~
cd Kart-Public
sudo install -Dm755 bin/Linux64/Release/lsdl2srb2kart /usr/local/bin/srb2kart
sudo install -Dm644 srb2.png /usr/local/share/pixmaps/srb2kart.png
cd ~
mkdir ~/.srb2kart
cd .srb2kart
echo -e "${color}Obtaining base game assets...${nc}"
wget https://github.com/STJr/Kart-Public/releases/download/v1.6/AssetsLinuxOnly.zip
echo -e "${color}Extracting base game assets...${nc}"
7z x AssetsLinuxOnly.zip "*.kart" "*.srb" "mdls.dat" "mdls/*"
rm AssetsLinuxOnly.zip
if [ $cleanupexec = 1 ]
then
	echo -e "${color}Performing cleanup...${nc}"
	cd ~
	rm -rf ~/Kart-Public
fi
echo -e "${color}The script is complete!${nc}"
if [ -f /var/run/reboot-required ] 
then
	echo -e "${warn}A reboot requirement was detected. Do you want to want to reboot now?${nc}"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) dorestart=1; break;;
			No ) dorestart=0; break;;
		esac
	done
	if [ $dorestart = 1 ]
	then
		echo -e "${color}Restarting...${nc}"
		sudo reboot
	fi
fi