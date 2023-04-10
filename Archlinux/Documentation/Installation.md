----------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'Archlinux </p>

----------------------------------------------------------------------------------------------------------------------------------------

#### A ajouter
```
Fuseau Horaire + Synchronisation
> timedatectl set-timezone Europe/Paris
> timedatectl set-ntp no

nano /etc/ntp.conf
server 0.fr.pool.ntp.org
server 1.fr.pool.ntp.org
server 2.fr.pool.ntp.org
server 3.fr.pool.ntp.org
systemctl restart ntpd
```

#### Bug
```
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Clavier en Azerty
```bash
loadkeys fr;
```
#### Pacman
```bash
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
sed -i -e "s/\#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Partitionnement (HDD)
```
DISK=/dev/sda
SIZE_BOOT=+512M
SIZE_SWAP=+2G
SIZE_SYST=+10G
SIZE_HOME=+19.5G
LVM_NAMEVG=Vg0
```

##### Création des partitions
```bash
dd if=/dev/zero of=${DISK} bs=512 count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT" ; echo "t" ; echo "1" ; echo "w") | fdisk $DISK;
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK;
(echo "p") | fdisk $DISK | grep $DISK;
```

#### Création du LVM
```bash
echo "yes" | lvremove HOME $LVM_NAMEVG;
echo "yes" | lvremove SYSTEM $LVM_NAMEVG;
echo "yes" | lvremove SWAP $LVM_NAMEVG;
echo "yes" | vgremove $LVM_NAMEVG;
echo "yes" | pvremove ${DISK}2;

echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $LVM_NAMEVG ${DISK}2;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG;
```
#### Formatage des partitions
```bash
echo "yes" | mkfs.fat -F32 ${DISK}1;
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/HOME;
```
#### Montage des partitions
```bash
swapon /dev/$LVM_NAMEVG/SWAP;
mount /dev/$LVM_NAMEVG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;
df -h | grep "/mnt"; swapon -s | tail -n 1;
```

----------------------------------------------------------------------------------------------------------------------------------------
#### Partitionnement (NVME)
##### Déclaration des variables (Remplacer X par le Disque)
```
DISK=/dev/nvmeXn1
SIZE_BOOT=+512M
SIZE_SWAP=+4G
SIZE_SYST=+10G
SIZE_HOME=+20G
LVM_NAMEVG=Vg0
```
##### Création des partitions
```bash
dd if=/dev/zero of=${DISK} bs=512 count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT" ; echo "t" ; echo "1" ; echo "w") | fdisk $DISK;
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK;
(echo "p") | fdisk $DISK | grep $DISK;
```
#### Création du LVM
```bash
echo "yes" | pvcreate ${DISK}p2;
echo "yes" | vgcreate $LVM_NAMEVG ${DISK}p2;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG;
```
#### Formatage des partitions
```bash
echo "yes" | mkfs.fat -F32 ${DISK}p1;
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/HOME;
```
#### Montage des partitions
```bash
swapon /dev/$LVM_NAMEVG/SWAP;
mount /dev/$LVM_NAMEVG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}p1  /mnt/boot;
df -h | grep "/mnt"; swapon -s | tail -n 1;
```
<br />




----------------------------------------------------------------------------------------------------------------------------------------
#### Installation des paquets
##### Paquets de Base
```bash
pacstrap /mnt base linux linux-lts;
``` 
#### Pilotes
```bash
pacstrap /mnt amd-ucode;
pacstrap /mnt broadcom-wl;
pacstrap /mnt linux-firmware;
pacstrap /mnt linux-headers;
pacstrap /mnt ntfs-3g;
pacstrap /mnt virtualbox-guest-utils;
```
#### Réseaux
```bash
pacstrap /mnt dhclient dhcpcd dnsutils iw iwd net-tools networkmanager wireless-regdb;
```
#### Le Son
```bash
pacstrap /mnt pulseaudio pulseaudio-alsa;
```
#### Librairies
``` bash
pacstrap /mnt base-devel fakeroot go;
pacstrap /mnt gtk-engine-murrine gtk-engines;
```
#### Utilitaires (Ligne de commandes)
``` bash 
pacstrap /mnt bash-completion curl git gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb lsb-release lvm2 man nano neofetch p7zip smbclient sudo unzip; usbutils wget zip;
```
#### Fonctions
```bash
pacstrap /mnt logrotate ntp openssh samba tlp tlp-rdw;
```

#### FSTAB (Boot, Swap, Home, System)
```bash
clear;
UUID_ESP=$(blkid  | grep vfat | grep -v "EFI system partition" | cut -d '"' -f 2)
genfstab -U /mnt >> /mnt/etc/fstab;
echo "UUID=$UUID_ESP /boot	auto rw,relatime 0 0" >> /mnt/etc/fstab;
```
#### Chroot
```bash
arch-chroot /mnt
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Préparation du Système (Partie I)
##### Installation du démarrage EFI avec SystemD
```bash
# ---------------------------------------------------------------------------------------------
UUID_SYSTEM=$(blkid | grep 'SYSTEM: UUID=' | cut -d '"' -f 2);
# ---------------------------------------------------------------------------------------------
bootctl --path=/boot install;
# ---------------------------------------------------------------------------------------------
echo "default arch01.conf
timeout 5
console-mode max
editor no" > /boot/loader/loader.conf;
# ---------------------------------------------------------------------------------------------
echo "title Arch Linux (Normal)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
initrd  /amd-ucode.img
options root=UUID=$UUID_SYSTEM rw quiet splash loglevel=3" > /boot/loader/entries/arch01.conf;
# ---------------------------------------------------------------------------------------------
echo "title Arch Linux (Recovery)
linux   /vmlinuz-linux
initrd  /initramfs-linux-fallback.img
initrd  /amd-ucode.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch02.conf;
# ---------------------------------------------------------------------------------------------
bootctl update;
bootctl;
# ---------------------------------------------------------------------------------------------
```
##### Nom de la machine
```bash
clear;
NAME=Drthrax74
DOM=home
echo "127.0.0.1       localhost
127.0.1.1       $NAME        $NAME
#127.0.1.1      $NAME.$DOM        $NAME" > /etc/hosts;
echo "$NAME" > /etc/hostname;
```
##### Gestions des utilisateurs
```bash
USERNAME=marc
ID=1000
PASSWORD=admin
COMMENT="Marc"
/usr/sbin/useradd --home-dir /home/$USERNAME --base-dir /home/$USERNAME --uid $ID --groups wheel,storage,power --no-user-group --shell /bin/bash --comment\"$COMMENT\" --create-home $USERNAME;
(echo "$USERNAME:$PASSWORD") | chpasswd;
(echo "root:$PASSWORD") | chpasswd;
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin;
```

##### Environnement de l'utilisateur
```bash
runuser -l $USERNAME -c "mkdir -p ~/.config/";
runuser -l $USERNAME -c 'echo "
XDG_DESKTOP_DIR=\"\$HOME/Bureau\";
XDG_DOCUMENTS_DIR=\"\$HOME/Documents\"
XDG_DOWNLOAD_DIR=\"\$HOME/Telechargements\"
XDG_TEMPLATES_DIR=\"\$HOME/Templates\"
XDG_MUSIC_DIR=\"\$HOME/Musiques\"
XDG_PICTURES_DIR=\"\$HOME/Images\"
XDG_PUBLICSHARE_DIR=\"\$HOME/Public\"
XDG_VIDEOS_DIR=\"\$HOME/Videos\" " > $HOME/.config/user-dirs.dirs';

runuser -l $USERNAME -c "mkdir Bureau Documents Telechargements Templates Musiques Images Public Videos";
```

##### Langue en Français
```bash
echo 'LANG=fr_FR.UTF-8'   > /etc/locale.conf;
echo 'KEYMAP=fr-latin9'   > /etc/vconsole.conf;
echo 'FONT=eurlatgr'     >> /etc/vconsole.conf;
echo 'fr_FR.UTF-8 UTF-8'  > /etc/locale.gen;
locale-gen;

mkdir -p /etc/X11/xorg.conf.d/;
echo 'Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option "XkbLayout"     "fr"
    Option "XkbVariant"    "oss"
    Option "XkbOptions"    "compose:menu,terminate:ctrl_alt_bksp"
EndSection' > /etc/X11/xorg.conf.d/00-keyboard.conf;
```

##### MKinitCPIO
```
sed -i -e "s/HOOKS\=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /etc/mkinitcpio.conf;
mkinitcpio -p linux;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Préparation du Système (Partie II)

##### Yay
```bash
runuser -l $USERNAME -c 'git clone https://aur.archlinux.org/yay.git /tmp/yay;'
runuser -l $USERNAME -c 'cd /tmp/yay && makepkg -si --noconfirm;'
```

##### Les services
```bash
systemctl enable avahi-daemon.service;
systemctl enable avahi-dnsconfd.service;
systemctl enable lightdm;
systemctl enable NetworkManager;
systemctl enable sshd;
systemctl enable ntpd;
```
