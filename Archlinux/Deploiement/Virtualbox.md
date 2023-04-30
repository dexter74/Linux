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
pacstrap /mnt logrotate;
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
###### FSTAB
```bash
genfstab -U /mnt > /mnt/etc/fstab;
```
###### Chroot (ps -fu; kill -9 XXXX)
```base
arch-chroot /mnt
```

###### Déclaration de Variable
```bash
NAME=Drthrax74
DOM=home
USERNAME=marc
ID=1000
PASSWORD=admin
COMMENT='Marc Jaffré'
```

###### Pacman
```bash
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /mnt/etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /mnt/etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
###### Autoriser SSH (root)
```bash
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config;
```

###### Langue FR et Clavier en Azerty
```bash
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

mkdir -p /etc/X11/xorg.conf.d/;
echo 'Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option "XkbLayout"     "fr"
    Option "XkbVariant"    "oss"
    Option "XkbOptions"    "compose:menu,terminate:ctrl_alt_bksp"
EndSection' > /etc/X11/xorg.conf.d/00-keyboard.conf;
```

###### MKINITCPIO
```bash
clear;
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.old;
chattr +i /mnt/etc/mkinitcpio.conf.old;
sed -i -e "s/HOOKS\=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /etc/mkinitcpio.conf;
mkinitcpio -p linux;
```

###### UEFI Boot (Loader + Entrées)
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

###### Nom de la Machine
```bash
clear;
echo "127.0.0.1       localhost
127.0.1.1       $NAME        $NAME
#127.0.1.1      $NAME.$DOM        $NAME" > /etc/hosts;
echo "$NAME" > /etc/hostname;
```

###### Les utilisateurs de la machine
```bash
clear;
/usr/sbin/userdel -r $USERNAME 2>/dev/null;
/usr/sbin/useradd --home-dir /home/$USERNAME --base-dir /home/$USERNAME --uid $ID --groups wheel,storage,power --no-user-group --shell /bin/bash --comment "$COMMENT" --create-home $USERNAME;

(echo "$USERNAME:$PASSWORD") | chpasswd;
(echo "root:$PASSWORD") | chpasswd;
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin;
```

###### Profil utilisateur
```bash
clear;
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

###### YAY
```bash
clear;
runuser -l $USERNAME -c 'git clone https://aur.archlinux.org/yay.git /tmp/yay;'
runuser -l $USERNAME -c 'cd /tmp/yay && makepkg -si --noconfirm;'
```

###### Services
```bash
clear;
systemctl enable avahi-daemon.service;
systemctl enable avahi-dnsconfd.service;
systemctl enable NetworkManager;
systemctl enable sshd;
systemctl enable ntpd;
systemctl enable systemd-timesyncd.service;
```
