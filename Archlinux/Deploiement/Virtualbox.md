--------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation d'Archlinux sous Virtualbox </p>


--------------------------------------------------------------------------------------------------------------------------------------------
### Création de la Machine Virtuelle
```
Type d'installation: EFI
Disque-Dur: 32 Go
Mémoire-Vive: 4 Go
```

#### Redirection de Port (Configuration > Réseau)
Permet l'accès SSH depuis l'hôte. (Port 22 de la VM rediriger vers le port 22 de la machine hôte Windows)

![image](https://user-images.githubusercontent.com/35907/235335576-9f380bc6-31b5-43a7-a757-a05491d15cfb.png)

<br />

--------------------------------------------------------------------------------------------------------------------------------------------
### Connexion SSH
###### Définir le clavier en FR
```bash
loadkeys fr;
```
###### Définir le mot de passe du compte root
```
passwd;
```

###### Se connecter en SSH
L'adresse de bouclage `127.0.0.1` ou `localhost` sur le port 22 qui correspond à au port d'accès externe le VM.
```
ssh root@127.0.0.1 -p 22
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
### Préparation du Disque-Dur d'ArchLinux
###### Déclaration des variables
```bash
DISK=/dev/sda
BOOT=+512M
SWAP=+3G
SYSTEM=+20G
HOME=+8G
VG=vg0
```

###### Pacman
```bash
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```

###### Disque-Dur
```bash
clear;
mount -R -f /mnt ;
swapoff -a -v;
echo "yes" | lvremove /dev/$VG/SWAP;
echo "yes" | lvremove /dev/$VG/SYSTEM;
echo "yes" | lvremove /dev/$VG/HOME;
echo "yes" | vgremove $VG;
echo "yes" | pvremove ${DISK}2;

dd if=/dev/zero of=${DISK}  bs=512  count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$BOOT" ; echo "t" ; echo "1" ; echo "w")      | fdisk $DISK; # EFI
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK; # LVM
partprobe ${DISK}2;
lsblk | grep "sd[a-z]";
```

###### LVM
```bash
clear;
echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $VG ${DISK}2;
echo "yes" | lvcreate -n SWAP   -L $SWAP $VG;
echo "yes" | lvcreate -n SYSTEM -L $SYSTEM $VG;
echo "yes" | lvcreate -n HOME   -L $HOME $VG;
echo "yes" | mkfs.fat -F32 ${DISK}1;
echo "yes" | mkswap /dev/$VG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$VG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$VG/HOME;
swapon /dev/$VG/SWAP;
mount /dev/$VG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$VG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;

lsblk | grep "sd[a-z]\|SWAP\|$VG";
```

###### Nettoyage
```bash
rm -rf /mnt 2>/dev/null;
```

###### Packages
```bash

pacstrap /mnt --noconfirm base
pacstrap /mnt --noconfirm linux
pacstrap /mnt --noconfirm base-devel
pacstrap /mnt --noconfirm fakeroot

pacstrap /mnt --noconfirm efibootmgr
pacstrap /mnt --noconfirm amd-ucode
pacstrap /mnt --noconfirm lvm2
pacstrap /mnt --noconfirm virtualbox-guest-utils

pacstrap /mnt --noconfirm dhcpcd
pacstrap /mnt --noconfirm dhclient

pacstrap /mnt --noconfirm sudo
pacstrap /mnt --noconfirm openssh
pacstrap /mnt --noconfirm go
pacstrap /mnt --noconfirm git
```

###### FSTAB
```bash
genfstab -U /mnt > /mnt/etc/fstab;
```

###### Chroot
```base
# Reprendre la main sur un Chroot: ps -fu; kill -9 XXXX
arch-chroot /mnt
```

###### Pacman
```bash
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /mnt/etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /mnt/etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```

###### Langue FR et Clavier en Azerty
```bash
echo 'LANG=fr_FR.UTF-8'                 > /mnt/etc/locale.conf;
echo 'LC_CTYPE="fr_FR.UTF-8"'          >> /mnt/etc/locale.conf;
echo 'LC_NUMERIC="fr_FR.UTF-8"'        >> /mnt/etc/locale.conf;
echo 'LC_TIME="fr_FR.UTF-8"'           >> /mnt/etc/locale.conf;
echo 'LC_COLLATE="fr_FR.UTF-8"'        >> /mnt/etc/locale.conf;
echo 'LC_MONETARY="fr_FR.UTF-8"'       >> /mnt/etc/locale.conf;
echo 'LC_MESSAGES='                    >> /mnt/etc/locale.conf;
echo 'LC_PAPER="fr_FR.UTF-8"'          >> /mnt/etc/locale.conf;
echo 'LC_NAME="fr_FR.UTF-8"'           >> /mnt/etc/locale.conf;
echo 'LC_ADDRESS="fr_FR.UTF-8"'        >> /mnt/etc/locale.conf;
echo 'LC_TELEPHONE="fr_FR.UTF-8"'      >> /mnt/etc/locale.conf;
echo 'LC_MEASUREMENT="fr_FR.UTF-8"'    >> /mnt/etc/locale.conf;
echo 'LC_IDENTIFICATION="fr_FR.UTF-8"' >> /mnt/etc/locale.conf;
echo 'LC_ALL='                         >> /mnt/etc/locale.conf;
echo 'LANGUAGE="fr_FR"'                >> /mnt/etc/locale.conf;
echo 'KEYMAP=fr-latin9'                 > /mnt/etc/vconsole.conf;
echo 'FONT=eurlatgr'                   >> /mnt/etc/vconsole.conf;

echo 'fr_FR.UTF-8 UTF-8'                > /mnt/etc/locale.gen;
arch-chroot /mnt locale-gen;
```

###### MKINITCPIO
```bash
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.old;
chattr +i /mnt/etc/mkinitcpio.conf.old;
sed -i -e "s/HOOKS\=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /mnt/etc/mkinitcpio.conf;
arch-chroot /mnt mkinitcpio -p linux;
```

###### UEFI Boot (Loader + Entrées)
```bash
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.old;
chattr +i /mnt/etc/mkinitcpio.conf.old;
sed -i -e "s/HOOKS\=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /mnt/etc/mkinitcpio.conf;
arch-chroot /mnt mkinitcpio -p linux;
```
