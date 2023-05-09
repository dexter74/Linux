### Informations
```
Distribution      : Debian 11
Nom de la machine : proxmox.lan
Carte Graphique   : AMD GPU Radeon 6700XT
Carte Wifi        : Broadcom BCM4352 802.11ac
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
apt install -y firmware-amd-graphics
apt install -y git;
apt install -y gnome-disk-utility;
apt install -y sudo;
apt install -y timeshift;
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

### Pilote Graphique 6700XT:
```
```
