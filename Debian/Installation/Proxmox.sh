###################################################################################################################
# Script: proxmox.sh
# Description:
# - Ajout de l'utilisateur au groupe sudo
# - Installation du Pilote Graphique AMD (Problème de detection du GPU VGA)
# - Installation de Proxmox-PVE
# - Mise à jour du Kernel
#
###################################################################################################################
# Nettoyage de la console #
###########################
clear;

###################################################################################################################
# Langue FR #
#############
localectl set-x11-keymap fr pc105 fr terminate:ctrl_alt_bksp;


###################################################################################################################
# AJouter l'utilisateur au groupe Sudo #
########################################
MONUSER=$(id 1000 | cut -d ")" -f 1 | cut -d "(" -f 2)
sudo adduser $MONUSER sudo;

###################################################################################################################
# Dépôts #
##########
cp /etc/apt/sources.list /etc/apt/sources.list.old;
echo "deb     http://ftp.fr.debian.org/debian/           bullseye main non-free
deb-src http://ftp.fr.debian.org/debian/           bullseye main
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib" > /etc/apt/sources.list;

###################################################################################################################
# Installation de paquet #
##########################
apt update;
apt install -y git;
apt install -y ntfs-3g;
apt install -y sudo;
apt install -y timeshift;

###################################################################################################################
# Dépôt Backport #
##################
sed -i -e "s/bullseye main non-free/bullseye-backports main non-free/g" /etc/apt/sources.list;
apt update;
apt install -y firmware-amd-graphics;
###################################################################################################################
# Dépôt Classique #
###################
sed -i -e "s/bullseye-backports main non-free/bullseye main non-free/g" /etc/apt/sources.list;
apt update;

###################################################################################################################
# Configuration de l'interface #
################################
#NAME_INTERFACE=$(ip add | grep -v "vmbr[0-9]:\|lo" | grep "[0-9]: " | cut -d ":" -f 2 | cut -c 2-9)
NAME_INTERFACE=$(ip link | grep -v "lo:" | grep "UP" | cut -d ":" -f 2 | cut -c 2-7)
IP=192.168.0.4
MASK=24
PASSERELLE=192.168.0.1
DNS1=192.168.0.1
DNS2=8.8.8.8

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
  dns-nameservers ${DNS1} ${DNS2}

#####################################
# Pont 0
auto vmbr0
  iface vmbr0 inet static
  address ${IP}/${MASK}
  gateway ${PASSERELLE}
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
echo "" > /etc/motd
###################################################################################################################
#clear;
#dpkg --list | grep linux-image;
