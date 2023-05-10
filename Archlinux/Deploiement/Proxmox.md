--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### <p align='center'> Installation d'Archlinux</p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Création de la VM
```
Contrôleur : VMware PVSCSI
Disque-Dur : 32 Go
```


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Live CD
Démarrer la machine et taper les commandes suivantes pour permettre l'accès ssh.

#### Langue FR + Mot de pass + Récupérer IP poste
```bash
loadkeys fr;
passwd;
ip add | grep 192.168;
```

#### Connexion en SSH depuis Windows
```
ssh root@<IP du poste>
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Préparation de l'environnement
#### A. Information sur la machine
```bash
root@archiso ~ # lsblk
#NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
#loop0   7:0    0 706.5M  1 loop /run/archiso/airootfs
#sda     8:0    0    32G  0 disk
#sr0    11:0    1 818.3M  0 rom  /run/archiso/bootmnt

root@archiso ~ # lspci -k | grep -i "network\|vga" -A2 | grep -v Sub
 # 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
 #         Kernel driver in use: bochs-drm
 
 # 06:12.0 Ethernet controller: Red Hat, Inc. Virtio network device
 #         Kernel driver in use: virtio-pci
```

#### B. Gestion du Disque-Dur
##### Partitionnements
Le Disque-dur `/dev/sda` aura une partition `EFI` et une partition `LVM`.

La partition `LVM` aura comme nom de Groupe de volume `vg0` et il qui contiendra les LVS `HOME`, `SYSTEM` et `SWAP`.

```bash
DISK=/dev/sda
BOOT=+512M
SWAP=+3G
SYSTEM=+20G
HOME=+8G
VG=vg0

clear;
dd if=/dev/zero of=${DISK}  bs=512  count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$BOOT" ; echo "t" ; echo "1" ; echo "w")      | fdisk $DISK; # EFI
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK; # LVM
partprobe ${DISK}2;
```
##### Création des LVS
```
clear;
echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $VG ${DISK}2;
echo "yes" | lvcreate -n SWAP   -L $SWAP $VG;
echo "yes" | lvcreate -n SYSTEM -L $SYSTEM $VG;
echo "yes" | lvcreate -n HOME   -L $HOME $VG;
```
##### Formatage des Partitions
```bash
echo "yes" | mkfs.fat -F32 ${DISK}1;
echo "yes" | mkswap /dev/$VG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$VG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$VG/HOME;
```

##### Monter les partitions 
```bash
swapon /dev/$VG/SWAP;
mount /dev/$VG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$VG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;
```

##### Vérification
```bash
# root@archiso ~ # lsblk| grep "sd[a-z]\|SWAP\|$VG";
# sda              8:0    0    32G  0 disk
# ├─sda1           8:1    0   512M  0 part /mnt/boot
# └─sda2           8:2    0  31.5G  0 part
#   ├─vg0-SWAP   253:0    0     3G  0 lvm  [SWAP]
#   ├─vg0-SYSTEM 253:1    0    20G  0 lvm  /mnt
#   └─vg0-HOME   253:2    0     8G  0 lvm  /mnt/home
```

##### Nettoyage Du Système
```bash
rm -rf /mnt 2>/dev/null;
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### IV. Installation du Système
#### A. Installation des paquets
```bash
pacstrap /mnt amd-ucode;
pacstrap /mnt base;
pacstrap /mnt base-devel;
pacstrap /mnt bash-completion;
pacstrap /mnt blueman;
pacstrap /mnt curl;
pacstrap /mnt binutils;
pacstrap /mnt efibootmgr;
pacstrap /mnt dhcpcd;
pacstrap /mnt dhclient;
pacstrap /mnt dnsutils;
pacstrap /mnt fakeroot;
pacstrap /mnt gtk-engine-murrine;
pacstrap /mnt gtk-engines;
pacstrap /mnt git;
pacstrap /mnt go;
pacstrap /mnt gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb;
pacstrap /mnt linux;
pacstrap /mnt linux-firmware;
pacstrap /mnt linux-headers;
pacstrap /mnt lsb-release;
pacstrap /mnt lvm2;
pacstrap /mnt man;
pacstrap /mnt nano;
pacstrap /mnt neofetch;
pacstrap /mnt net-tools;
pacstrap /mnt networkmanager;
pacstrap /mnt ntfs-3g;
pacstrap /mnt ntp;
pacstrap /mnt openssh;
pacstrap /mnt p7zip;
pacstrap /mnt pacman-contrib;
pacstrap /mnt pulseaudio;
pacstrap /mnt pulseaudio-alsa;
pacstrap /mnt pulseaudio-bluetooth;
pacstrap /mnt pulseaudio-equalizer;
pacstrap /mnt samba;
pacstrap /mnt smbclient;
pacstrap /mnt sudo;
pacstrap /mnt unzip;
pacstrap /mnt usbutils;
pacstrap /mnt virtualbox-guest-utils;
pacstrap /mnt wget;
pacstrap /mnt zip;

```
