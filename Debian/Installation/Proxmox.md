---------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de l'applicatif Proxmox sur Debian 11 </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------
#### I. Présentation de l'environnement
```
Distribution      : Debian 11
Nom de la machine : proxmox.lan
Carte Graphique   : AMD GPU Radeon 6700XT
Carte Wifi        : Broadcom BCM4352 802.11ac
Storage Data      : /data
Nom d'utilisateur : marc
```

---------------------------------------------------------------------------------------------------------------------------------------------------------
#### II. Installation de Débian
##### A. Partitionnement
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

##### B. Dépôt (Défaut)
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

##### C. Dépôt (Modifier)
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

##### D. Installation des paquets
```bash
apt install -y git;
apt install -y gnome-disk-utility;
apt install -y sudo;
apt install -y timeshift;
```

##### E. GPU ([Topic](https://debian-facile.org/viewtopic.php?pid=395680#p395680) | [Package](https://packages.debian.org/search?keywords=firmware-amd-graphics))
```bash
clear;
sed -i -e "s/bullseye main non-free/bullseye-backports main non-free/g" /etc/apt/sources.list;
apt update;
apt upgrade -y;
apt install -y firmware-amd-graphics;
sed -i -e "s/bullseye-backports main non-free/bullseye main non-free/g" /etc/apt/sources.list;
```

##### F. Ajouter Utilisateur au groupe sudo
La variable MONUSER récupére le nom de l'utilisateur ayant l'ID 1000.
```bash
clear;
MONUSER=$(id 1000 | cut -d ")" -f 1 | cut -d "(" -f 2)
sudo adduser $MONUSER sudo;
```

##### G. Création de la sauvegarde Système
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


---------------------------------------------------------------------------------------------------------------------------------------------------------
#### Installation de Proxmox
##### A. Configuration de l'ip Static
```bash
clear;
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
#####################################" > /etc/network/interfaces; cat /etc/network/interfaces;
```

##### B. Relance du service
Ne pas tenir compte de l'erreur !
```bash
clear;
systemctl restart networking.service;
```



##### C. Nom de la Machine
```bash
clear;
echo "proxmox" > /etc/hostname;
echo "127.0.0.1       localhost
192.168.0.4     proxmox.lan proxmox

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts;
```

##### D. Dépôt Proxmox
```bash
clear;
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list;
```

##### E. Clé GPG
```bash
clear;
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg;
```

##### F. Mise à jour
```bash
clear;
apt update;
apt full-upgrade -y;
```

##### G. Installer les packages de Proxmox
Choisir `Local uniquement` .
```bash
clear;
apt remove -y os-prober;
apt install -y proxmox-ve postfix open-iscsi;
```

```
W: Possible missing firmware /lib/firmware/amdgpu/yellow_carp_gpu_info.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/vangogh_gpu_info.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_rlc.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_mec2.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_mec.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_me.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_pfp.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_ce.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_sdma1.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/cyan_skillfish_sdma.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/sienna_cichlid_mes.bin for module amdgpu
W: Possible missing firmware /lib/firmware/amdgpu/navi10_mes.bin for module amdgpu
```

##### H. Commenter le Dépôt Entreprise de Proxmox
```bash
clear;
sed -i -e "s/^deb/#deb/g" /etc/apt/sources.list.d/pve-enterprise.list;
``` 

##### I. Installer le Noyaux par défaut de Proxmox 7.0 (Stable)
```bash
clear;
apt install -y pve-kernel-5.15;
```

##### J. Installer le Noyaux de Proxmox (Last Release)
```bash
clear;
LAST_KERNEL_PVE=$(apt search pve-kernel | grep stable | grep -v "helper\|libc" | tail -n 1 | cut -d "/" -f 1)
apt install -y $LAST_KERNEL_PVE;

# dpkg --list | grep linux-image;
```

##### K. Reboot
```
systemctl reboot;
```

##### L. Suite du Guide
https://github.com/dexter74/Linux/blob/main/Proxmox/Install.md
