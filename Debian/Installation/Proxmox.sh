###################################################################################################################
# Script: proxmox.sh
# Description:
# - Installation du Pilote Graphique AMD (La parte VGA est pas détecté sans)
# - Installation de Proxmox-PVE
# - Mise à jour du Kernel
#
###################################################################################################################
clear;

###################################################################################################################
MONUSER=$(id 1000 | cut -d ")" -f 1 | cut -d "(" -f 2)
sudo adduser $MONUSER sudo;

###################################################################################################################
echo "deb     http://ftp.fr.debian.org/debian/           bullseye main non-free
deb-src http://ftp.fr.debian.org/debian/           bullseye main
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib" > /etc/apt/sources.list;

sed -i -e "s/bullseye main non-free/bullseye-backports main non-free/g" /etc/apt/sources.list;
apt update;

# NE SURTOUT PAS FAIRE UPGRADE !
#apt upgrade -y;
apt install -y firmware-amd-graphics;

sed -i -e "s/bullseye-backports main non-free/bullseye main non-free/g" /etc/apt/sources.list;
apt update;

###################################################################################################################
NAME_INTERFACE=$(ip add | grep -v "vmbr[0-9]:\|lo" | grep "[0-9]: " | cut -d ":" -f 2 | cut -c 2-9)
echo "#####################################
source /etc/network/interfaces.d/*
#####################################
# Adresse de Bouclage
auto lo
iface lo inet loopback
#####################################
# Interface Physique
auto $NAME_INTERFACE
  iface $NAME_INTERFACE inet manual
  dns-domain lan
  dns-nameservers 192.168.0.1 8.8.8.8
#####################################
# Pont 0
auto vmbr0
  iface vmbr0 inet static
  address 192.168.0.4/24
  gateway 192.168.0.1
  bridge-ports $NAME_INTERFACE
  bridge-stp off
  bridge-fd 0
#####################################
# Pont 1
auto vmbr1
  iface vmbr1 inet static
  address 192.168.10.0/24
  bridge-ports none
  bridge-stp off
  bridge-fd 0
#####################################" > /etc/network/interfaces;

###################################################################################################################
echo "proxmox" > /etc/hostname;
echo "127.0.0.1       localhost
192.168.0.4     proxmox.lan proxmox

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts;

###################################################################################################################
clear;
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list;
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg;

###################################################################################################################
clear;
apt update;
apt full-upgrade -y;

###################################################################################################################
clear;
apt install -y proxmox-ve postfix open-iscsi;
###################################################################################################################
clear;
sed -i -e "s/^deb/#deb/g" /etc/apt/sources.list.d/pve-enterprise.list;

###################################################################################################################
clear;
apt install -y pve-kernel-5.15;
###################################################################################################################
#clear;
#dpkg --list | grep linux-image;
