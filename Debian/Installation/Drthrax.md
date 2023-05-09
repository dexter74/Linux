### Informations
```
Distribution   : Debian 11
Carte Graphique: AMD GPU Radeon 6700XT
Carte Wifi     : Broadcom BCM4352 802.11ac
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
