----------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'Archlinux </p>

----------------------------------------------------------------------------------------------------------------------------------------

#### A ajouter
```
Connexion au Wifi au début
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

#### Connexion au WIFI
```bash
clear;
iwctl adapter list;
iwctl device list;

iwctl adapter phy0 set-property Powered on;
iwctl device wlan0 set-property Powered on;

iwctl station wlan0 scan;
iwctl station wlan0 get-networks;

iwctl station wlan0 connect Livebox-F28A --passphrase u7yCLyQED26nXW7EP7;
```

----------------------------------------------------------------------------------------------------------------------------------------
#### Partitionnement (HDD)
```
clear;
DISK=/dev/sda
SIZE_BOOT=+512M
SIZE_SWAP=+2G
SIZE_SYST=+19G
SIZE_HOME=+10G
LVM_NAMEVG=vg0
```

##### Création des partitions
```bash
clear;
umount -R /mnt 2>/dev/null;
swapoff /dev/$LVM_NAMEVG/SWAP 2>/dev/null;
dd if=/dev/zero of=${DISK} bs=512 count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT" ; echo "t" ; echo "1" ; echo "w") | fdisk $DISK;
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK;
```

```bash
clear;
(echo "p") | fdisk $DISK | grep $DISK;
```

#### Création du LVM
```bash
clear;
echo "yes" | lvremove HOME $LVM_NAMEVG 1>/dev/null;
echo "yes" | lvremove SYSTEM $LVM_NAMEVG 1>/dev/null;
echo "yes" | lvremove SWAP $LVM_NAMEVG 1>/dev/null;
echo "yes" | vgremove $LVM_NAMEVG 1>/dev/null;
echo "yes" | pvremove ${DISK}2 1>/dev/null;

echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $LVM_NAMEVG ${DISK}2;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG 1>/dev/null;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG 1>/dev/null;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG 1>/dev/null;
```
```bash
clear;
lvs;
```


#### Formatage des partitions
```bash
clear;
echo "yes" | mkfs.fat -F32 ${DISK}1 1>/dev/null;
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP 1>/dev/null;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/SYSTEM 1>/dev/null;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/HOME 1>/dev/null;
```
#### Montage des partitions
```bash
clear;
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
clear;
DISK=/dev/nvmeXn1
SIZE_BOOT=+512M
SIZE_SWAP=+2G
SIZE_SYST=+10G
SIZE_HOME=+10G
LVM_NAMEVG=vg0
```
##### Création des partitions
```bash
clear;
dd if=/dev/zero of=${DISK} bs=512 count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT" ; echo "t" ; echo "1" ; echo "w") | fdisk $DISK;
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK;
(echo "p") | fdisk $DISK | grep $DISK;
```
#### Création du LVM
```bash
clear;
echo "yes" | pvcreate ${DISK}p2;
echo "yes" | vgcreate $LVM_NAMEVG ${DISK}p2;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG;
```
#### Formatage des partitions
```bash
clear;
echo "yes" | mkfs.fat -F32 ${DISK}p1;
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$LVM_NAMEVG/HOME;
```
#### Montage des partitions
```bash
clear;
swapon /dev/$LVM_NAMEVG/SWAP;
mount /dev/$LVM_NAMEVG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}p1  /mnt/boot;
df -h | grep "/mnt"; swapon -s | tail -n 1;
```
<br />




----------------------------------------------------------------------------------------------------------------------------------------
#### Installation des paquets
#### Pacman
```bash
clear;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
sed -i -e "s/\#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
##### Purger
```bash
rm -rf /mnt;
```
##### Paquets de Base
```bash
pacstrap /mnt base linux;
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
#### Son
```bash
pacstrap /mnt pulseaudio pulseaudio-alsa pulseaudio-equalizer;
```
#### Bluetooth
```bash
pacstrap /mnt blueman pulseaudio-bluetooth;
```
#### Librairies
``` bash
pacstrap /mnt base-devel fakeroot go;
pacstrap /mnt gtk-engine-murrine gtk-engines;
```
#### Utilitaires (Ligne de commandes)
``` bash
pacstrap /mnt bash-completion binutils curl git gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb lsb-release lvm2 man nano neofetch p7zip pacman-contrib smbclient sudo unzip usbutils wget zip;

# cabextract lha lsof mtools reflector pacman-contrib nm-connection-editor
```
#### Fonctions
```bash
pacstrap /mnt logrotate;
pacstrap /mnt ntp;
pacstrap /mnt openssh;
pacstrap /mnt samba;
pacstrap /mnt tlp tlp-rdw;
```
#### FSTAB (Boot, Swap, Home, System)
```bash
clear;
genfstab -U /mnt > /mnt/etc/fstab;
cat /mnt/etc/fstab;
```
#### Chroot
```bash
clear;
arch-chroot /mnt
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Préparation du Système (Partie I)
##### Installation du démarrage EFI avec SystemD
```bash
clear;
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
options root=UUID=$UUID_SYSTEM rw quiet loglevel=3" > /boot/loader/entries/arch01.conf;
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

##### Langue en Français (A confirmer le bon fonctionnement)
```
localectl set-x11-keymap fr pc105 fr terminate:ctrl_alt_bksp;

#localectl list-locales             >> fr_FR.UTF-8
#localectl list-x11-keymap-models   >> pc105
#localectl list-x11-keymap-variants >> fr
#localectl list-x11-keymap-options  >> terminate:ctrl_alt_bksp
# @Forum: localectl --no-convert set-x11-keymap fr "" latin9
```

##### Langue en Français (Outdate)
```bash
clear;
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


###### Langue en Français (old)
```bash
clear;
export LANG=fr_FR.UTF-8;
echo 'LANG=fr_FR.UTF-8'                 > /etc/locale.conf;
echo 'LC_CTYPE="fr_FR.UTF-8"'          >> /etc/locale.conf;
echo 'LC_NUMERIC="fr_FR.UTF-8"'        >> /etc/locale.conf;
echo 'LC_TIME="fr_FR.UTF-8"'           >> /etc/locale.conf;
echo 'LC_COLLATE="fr_FR.UTF-8"'        >> /etc/locale.conf;
echo 'LC_MONETARY="fr_FR.UTF-8"'       >> /etc/locale.conf;
echo 'LC_MESSAGES='                    >> /etc/locale.conf;
echo 'LC_PAPER="fr_FR.UTF-8"'          >> /etc/locale.conf;
echo 'LC_NAME="fr_FR.UTF-8"'           >> /etc/locale.conf;
echo 'LC_ADDRESS="fr_FR.UTF-8"'        >> /etc/locale.conf;
echo 'LC_TELEPHONE="fr_FR.UTF-8"'      >> /etc/locale.conf;
echo 'LC_MEASUREMENT="fr_FR.UTF-8"'    >> /etc/locale.conf;
echo 'LC_IDENTIFICATION="fr_FR.UTF-8"' >> /etc/locale.conf;
echo 'LC_ALL='                         >> /etc/locale.conf;
echo 'LANGUAGE="fr_FR"'                >> /etc/locale.conf;
echo 'KEYMAP=fr-latin9'                 > /etc/vconsole.conf;
echo 'FONT=eurlatgr'                   >> /etc/vconsole.conf;
echo 'fr_FR.UTF-8 UTF-8'                > /etc/locale.gen;
locale-gen;
```


##### MKinitCPIO
```
clear;
sed -i -e "s/HOOKS\=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /etc/mkinitcpio.conf;
mkinitcpio -p linux;
```

##### Gestions des utilisateurs
```bash
clear;
USERNAME=marc
ID=1000
PASSWORD=admin
COMMENT='Marc Jaffré'

/usr/sbin/userdel -r $USERNAME 2>/dev/null;
/usr/sbin/useradd --home-dir /home/$USERNAME --base-dir /home/$USERNAME --uid $ID --groups wheel,storage,power --no-user-group --shell /bin/bash --comment "$COMMENT" --create-home $USERNAME;

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

<br />

----------------------------------------------------------------------------------------------------------------------------------------
#### Préparation du Système (Partie II)

#### Pacman
```bash
clear;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
sed -i -e "s/\#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
##### Yay
```bash
clear;
runuser -l $USERNAME -c 'git clone https://aur.archlinux.org/yay.git /tmp/yay;'
runuser -l $USERNAME -c 'cd /tmp/yay && makepkg -si --noconfirm;'
```

##### Les services
```bash
clear;
systemctl enable avahi-daemon.service;
systemctl enable avahi-dnsconfd.service;
systemctl enable NetworkManager;
systemctl enable sshd;
systemctl enable ntpd;
systemctl enable systemd-timesyncd.service;
```

##### Fuseau Horaire + Synchronisation
```bash
clear;
timedatectl set-timezone Europe/Paris;
timedatectl set-ntp true;

```

###### TimeZone (old)
```bash
clear; ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime;
```

###### Synchronisation Heure (old)
```bash
clear; hwclock --systohc;
```

###### Autoriser connexion SSH (Root)
```bash
clear;
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config;
```

----------------------------------------------------------------------------------------------------------------------------------------
#### Inteface Utilisateur

#### [Xorg](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Serveur_Affichage/readme.md)

#### [Pilote](https://github.com/dexter74/Linux/blob/main/Archlinux/Appz/Pilotes/readme.md)

#### [GUI](https://github.com/dexter74/Linux/blob/main/Archlinux/Appz/Environnements_Graphique/readme.md)

#### [Applets](https://github.com/dexter74/Linux/blob/main/Archlinux/Appz/Applets/readme.md)

#### [Lightdm](https://github.com/dexter74/Linux/blob/main/Archlinux/Appz/Gestionnaire_de_connexion/readme.md)

#### [Bureautique](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Bureautique)

#### [Partage](https://github.com/dexter74/Linux/blob/main/Archlinux/Documentation/Partage.md)

#### [Themes](https://github.com/dexter74/Linux/tree/main/Archlinux/themes)
