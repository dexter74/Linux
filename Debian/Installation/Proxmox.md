---------------------------------------------------------------------------------------------------------------------------------------------------------
<p align='center'> Installation de l'applicatif Proxmox sur Debian 11 </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------
### Informations
```
Distribution      : Debian 11
Nom de la machine : proxmox.lan
Carte Graphique   : AMD GPU Radeon 6700XT
Carte Wifi        : Broadcom BCM4352 802.11ac
Nom d'utilisateur : marc

Networking affichera que le réseau est KO !
```

### Partitionnement
```
Partition 1: ESP

Partition 2: LVM
 - Volume Group: vg0
  - LVM: Swap
  - LVM: SYSTEM  32 Go /
  - LVM: Home    10 Go /home
  - LVM: Data   500 Go /data
  - LVM: Backup 100 Go /backup
```

### Dépôt (Défaut)
```
deb     http://ftp.fr.debian.org/debian/           bullseye main
deb-src http://ftp.fr.debian.org/debian/           bullseye main
#
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
#
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
```

### Dépôt (Modifier)
```
deb     http://ftp.fr.debian.org/debian/           bullseye main non-free
deb-src http://ftp.fr.debian.org/debian/           bullseye main
#
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
#
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
```

### Installation des paquets
```bash
apt install -y git;
apt install -y gnome-disk-utility;
apt install -y sudo;
apt install -y timeshift;
```

### GPU
```

```

### Ajouter Utilisateur au groupe sudo
La variable MONUSER récupére le nom de l'utilisateur ayant l'ID 1000.
```bash
MONUSER=$(id 1000 | cut -d ")" -f 1 | cut -d "(" -f 2)
sudo adduser $MONUSER sudo;
```

### Création de la sauvegarde Système
```
Paramètres:
 - Type d'instantané: rsync
 - Emplacement      : dm-3 (Backup)
 - Planning         : Quotidienne (Conserver 7)
 - Misc : %d-%m-%Y %H:%M:%S

Dossiers Personnls:
- marc: Exclude All Files
- root: Exclude All Files

Patterns d'inclusion / Exclusion:
- /data/
```

### Proxmox
##### Configuration de l'ip Static
```bash
clear;
NAME_INTERFACE=$(ip add | grep UP | grep -v lo | cut -d ":" -f 2 | cut -d " " -f 2)
echo "##############################################
source /etc/network/interfaces.d/*
##############################################
auto lo
iface lo inet loopback
# Interface enp4s0
auto enp4s0
iface enp4s0 inet manual
        dns-domain lan
        dns-nameservers 192.168.0.1 8.8.8.8
##############################################
auto vmbr0
iface vmbr0 inet static
        address 192.168.0.4/24
        gateway 192.168.0.1
        bridge-ports enp4s0
        bridge-stp off
        bridge-fd 0
##############################################" > /etc/network/interfaces;
systemctl restart networking.service;
systemctl status networking.service;
```

##### Nom de la Machine
```bash
echo "proxmox" > /etc/hostname;
echo "127.0.0.1       localhost
192.168.0.4     proxmox.lan proxmox

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts;
```

###### Dépôt
```bash
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list;
```

###### Clé GPG
```bash
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg;
```

###### Mise à jour
```bash
apt update;
apt full-upgrade -y;
```

###### Installer les packages de Proxmox
Choisir `Local uniquement` .
```
apt install -y proxmox-ve postfix open-iscsi;
```


###### Installer le Noyaux par défaut de Proxmox 7.0 (Stable)
```bash
apt install -y pve-kernel-5.15;
```

###### Installer le Noyaux de Proxmox (Last Release)
```bash
LAST_KERNEL_PVE=$(apt search pve-kernel | grep stable | grep -v "helper\|libc" | tail -n 1 | cut -d "/" -f 1)
apt install -y $LAST_KERNEL_PVE;
```

###### Reboot
```
systemctl reboot;
```


#### Suite du Guide
https://github.com/dexter74/Linux/blob/main/Proxmox/Install.md
