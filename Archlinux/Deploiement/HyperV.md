---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'>    Installation d'Archlinux sur l'hyperviseur Hyper-V de Microsoft    </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### I. Création de la Machine Virtuelles ([WIKI](https://wiki.archlinux.org/title/Hyper-V#Virtual_machine_creation))
```
Pour les machines de Génération 2, le démarrage à partir d’un lecteur de CD/DVD physique n’est pas pris en charge.
```
<br />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### II. Préparation de l'accès distant

###### A. LiveCD
```bash
loadkeys fr;
(echo "admin"; echo "admin") | passwd;
```

###### B. Connexion en SSH depuis Windows
Pour facilité l'installation d'archlinux, l'utilisation d'un accès distant SSH permettra de faire des copier/coller.
```
ssh root@192.168.
```


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### III. Gestion du Disque-Dur
###### B. Déclaration des variables
```bash
clear;
DISK=/dev/sda
BOOT=+512M
SWAP=+3G
SYSTEM=+20G
HOME=+8G
VG=vg0
```

###### B. Création des partitions
```bash
clear;
dd if=/dev/zero of=${DISK}  bs=512  count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$BOOT" ; echo "t" ; echo "1" ; echo "w")       | fdisk $DISK; # MBR
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "136"; echo "w") | fdisk $DISK; # LVM
partprobe ${DISK}2;
```

##### C. Suppression du LVM
```
clear;
mount -R -f /mnt ;
swapoff -a -v;
echo "yes" | lvremove /dev/$VG/SWAP;
echo "yes" | lvremove /dev/$VG/SYSTEM;
echo "yes" | lvremove /dev/$VG/HOME;
echo "yes" | vgremove $VG;
echo "yes" | pvremove ${DISK}2;
```

##### Création des LVM
```
clear;
echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $VG ${DISK}2;
echo "yes" | lvcreate -n SWAP   -L $SWAP $VG;
echo "yes" | lvcreate -n SYSTEM -L $SYSTEM $VG;
echo "yes" | lvcreate -n HOME   -L $HOME $VG;
```
##### D. Formatage des Partitions
```bash
clear;
echo "yes" | mkfs -t ext4 ${DISK}1;
echo "yes" | mkswap /dev/$VG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$VG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$VG/HOME;
```

##### E. Monter les partitions 
```bash
clear;
swapon /dev/$VG/SWAP;
mount /dev/$VG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$VG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;
```

##### F. Vérification
```bash
clear;
lsblk| grep "sd[a-z]\|SWAP\|SYSTEM\|$VG";
```

##### G. Nettoyage Du Système
```bash
clear;
rm -rf /mnt 2>/dev/null;
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### IV. Installation des Paquets, FSTAB et Chroot

#### A. Pacman
```bash
clear;
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring 1>/dev/null;
```

#### B. Installation des paquets
```bash
clear;
pacstrap /mnt amd-ucode            1>/dev/null;
pacstrap /mnt base                 1>/dev/null;
pacstrap /mnt base-devel           1>/dev/null;
pacstrap /mnt bash-completion      1>/dev/null;
pacstrap /mnt curl                 1>/dev/null;
pacstrap /mnt binutils             1>/dev/null;
pacstrap /mnt dhcpcd               1>/dev/null;
pacstrap /mnt dhclient             1>/dev/null;
pacstrap /mnt dnsutils             1>/dev/null;
pacstrap /mnt fakeroot             1>/dev/null;
pacstrap /mnt gtk-engine-murrine   1>/dev/null;
pacstrap /mnt gtk-engines          1>/dev/null;
pacstrap /mnt git                  1>/dev/null;
pacstrap /mnt go                   1>/dev/null;
pacstrap /mnt gvfs                 1>/dev/null;
pacstrap /mnt linux                1>/dev/null;
pacstrap /mnt linux-firmware       1>/dev/null;
pacstrap /mnt linux-headers        1>/dev/null;
pacstrap /mnt lsb-release          1>/dev/null;
pacstrap /mnt lvm2                 1>/dev/null;
pacstrap /mnt man                  1>/dev/null;
pacstrap /mnt nano                 1>/dev/null;
pacstrap /mnt neofetch             1>/dev/null;
pacstrap /mnt net-tools            1>/dev/null;
pacstrap /mnt networkmanager       1>/dev/null;
pacstrap /mnt ntfs-3g              1>/dev/null;
pacstrap /mnt ntp                  1>/dev/null;
pacstrap /mnt openssh              1>/dev/null;
pacstrap /mnt p7zip                1>/dev/null;
pacstrap /mnt pacman-contrib       1>/dev/null;
pacstrap /mnt pulseaudio           1>/dev/null;
pacstrap /mnt pulseaudio-alsa      1>/dev/null;
pacstrap /mnt pulseaudio-equalizer 1>/dev/null;
pacstrap /mnt samba                1>/dev/null;
pacstrap /mnt smbclient            1>/dev/null;
pacstrap /mnt sudo                 1>/dev/null;
pacstrap /mnt unzip                1>/dev/null;
pacstrap /mnt usbutils             1>/dev/null;
pacstrap /mnt wget                 1>/dev/null;
pacstrap /mnt zip                  1>/dev/null;
```

#### Générer le FSTAB
```bash
genfstab -U /mnt > /mnt/etc/fstab;
```

#### Passage en Chroot
```bash
arch-chroot /mnt
```
