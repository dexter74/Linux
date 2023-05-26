--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### <p align='center'> Installation d'Archlinux</p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Création de la VM
```
Disque EFI   : Décocher Clé de préinscription (Empêche le boot EFI)
Contrôleur   : VMware PVSCSI
Disque-Dur   : 32 Go
Carte-réseau : vmbr0 
```


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Live CD
Démarrer la machine et taper les commandes suivantes pour permettre l'accès ssh.

#### Langue FR + Mot de pass + Récupérer IP poste
```bash
clear;
loadkeys fr;
passwd;
ip add | grep 192.168;
```

#### Connexion en SSH depuis Windows
```
ssh root@<IP du poste>
```

#### Information sur la machine
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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Préparation du stockage

#### A. Gestion du Disque-Dur
##### Partitionnements
Le Disque-dur `/dev/sda` aura une partition `EFI` et une partition `LVM`.

La partition `LVM` aura comme nom de Groupe de volume `vg0` et il qui contiendra les LVS `HOME`, `SYSTEM` et `SWAP`.
```bash
clear;
DISK=/dev/sda
BOOT=+512M
SWAP=+3G
SYSTEM=+20G
HOME=+8G
VG=vg0

dd if=/dev/zero of=${DISK}  bs=512  count=1;
(echo "g"; echo "w") | fdisk ${DISK};
(echo "n"; echo "1"; echo ""; echo "$BOOT" ; echo "t" ; echo "1" ; echo "w")      | fdisk $DISK; # EFI
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "43"; echo "w") | fdisk $DISK; # LVM
partprobe ${DISK}2;
```

##### Suppression du LVM
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
##### Formatage des Partitions
```bash
clear;
echo "yes" | mkfs.fat -F32 ${DISK}1;
echo "yes" | mkswap /dev/$VG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$VG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$VG/HOME;
```

##### Monter les partitions 
```bash
clear;
swapon /dev/$VG/SWAP;
mount /dev/$VG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$VG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;
```

##### Vérification
```bash
clear;
lsblk| grep "sd[a-z]\|SWAP\|SYSTEM\|$VG";

# sda              8:0    0    32G  0 disk
# ├─sda1           8:1    0   512M  0 part /mnt/boot
# └─sda2           8:2    0  31.5G  0 part
#   ├─vg0-SWAP   253:0    0     3G  0 lvm  [SWAP]
#   ├─vg0-SYSTEM 253:1    0    20G  0 lvm  /mnt
#   └─vg0-HOME   253:2    0     8G  0 lvm  /mnt/home
```

##### Nettoyage Du Système
```bash
clear;
rm -rf /mnt 2>/dev/null;
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### IV. Installation des Paquets, FSTAB et Chroot

#### Pacman
```bash
clear;
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring 1>/dev/null;
```

#### Installation des paquets
```bash
clear;
pacstrap /mnt amd-ucode            1>/dev/null;
pacstrap /mnt avahi                1>/dev/null;
pacstrap /mnt base                 1>/dev/null;
pacstrap /mnt base-devel           1>/dev/null;
pacstrap /mnt bash-completion      1>/dev/null;
pacstrap /mnt curl                 1>/dev/null;
pacstrap /mnt binutils             1>/dev/null;
pacstrap /mnt efibootmgr           1>/dev/null;
pacstrap /mnt dhcpcd               1>/dev/null;
pacstrap /mnt dhclient             1>/dev/null;
pacstrap /mnt dnsutils             1>/dev/null;
pacstrap /mnt fakeroot             1>/dev/null;
pacstrap /mnt gtk-engine-murrine   1>/dev/null;
pacstrap /mnt gtk-engines          1>/dev/null;
pacstrap /mnt git                  1>/dev/null;
pacstrap /mnt go                   1>/dev/null;
pacstrap /mnt gvfs                 1>/dev/null;
pacstrap /mnt gvfs-nfs             1>/dev/null;
pacstrap /mnt gvfs-smb             1>/dev/null;
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

pacstrap /mnt qemu-guest-agent     1>/dev/null;
```

#### Générer le FSTAB
```bash
clear;
genfstab -U /mnt > /mnt/etc/fstab;
```

#### Passage en Chroot
```bash
clear;
arch-chroot /mnt;
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### V. Préparation de l'environnement Utilisateur

#### Pacman
```bash
clear;
sed -i -e "s/\#ParallelDownloads \= 5/ParallelDownloads = 5/g" /etc/pacman.conf;
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring 1>/dev/null;
```

#### Déclaration des variables Systèmes
```bash
clear;

NAME=Archlinux
DOM=LAN

USERNAME=marc
ID=1000
PASSWORD=admin
COMMENT='Marc Jaffré'
```


#### Français
```bash
clear;
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

#### mkinitcpio
```bash
clear;
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.old;
chattr +i /etc/mkinitcpio.conf.old;
sed -i -e "s/HOOKS\=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems udev resume keyboard keymap sd-vconsole fsck)/g" /etc/mkinitcpio.conf;
mkinitcpio -p linux 1>/dev/null;
```

#### BootLoader EFI
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
linux   vmlinuz-linux
initrd  initramfs-linux.img
initrd  amd-ucode.img
options root=UUID=$UUID_SYSTEM rw loglevel=3" > /boot/loader/entries/arch01.conf;
# ---------------------------------------------------------------------------------------------
echo "title Arch Linux (Recovery)
linux   vmlinuz-linux
initrd  initramfs-linux-fallback.img
initrd  amd-ucode.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch02.conf;
# ---------------------------------------------------------------------------------------------
bootctl update;
bootctl;
```

#### Nom de la Machine
```bash
clear;
echo "127.0.0.1       localhost
127.0.1.1       $NAME        $NAME
#127.0.1.1      $NAME.$DOM        $NAME" > /etc/hosts;
echo "$NAME" > /etc/hostname;
```

#### Utilisateurs
```bash
clear;
/usr/sbin/userdel -r $USERNAME 2>/dev/null;
/usr/sbin/useradd --home-dir /home/$USERNAME --base-dir /home/$USERNAME --uid $ID --groups wheel,storage,power --no-user-group --shell /bin/bash --comment "$COMMENT" --create-home $USERNAME;

(echo "$USERNAME:$PASSWORD") | chpasswd;
(echo "root:$PASSWORD") | chpasswd;
```

#### Profil utilisateur
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
runuser -l $USERNAME -c "mkdir Bureau Documents Telechargements Templates Musiques Images Public Videos" 2>/dev/null;
```

#### Sudoers (Indispensable pour YAY)
```bash
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/admin;
```

#### Gestionnaire de paquet YAY
```bash
clear;
runuser -l $USERNAME -c 'git clone https://aur.archlinux.org/yay.git /tmp/yay' 2>/dev/null;
runuser -l $USERNAME -c 'cd /tmp/yay && makepkg -si --noconfirm'   1>/dev/null 2>/dev/null; 
```

#### YAY ([MKINITCPIO](https://wiki.archlinux.org/title/mkinitcpio))
```bash
clear;
runuser -l $USERNAME -c 'yay -Sy --noconfirm linux-firmware-qlogic' 1>/dev/null 2>/dev/null;
runuser -l $USERNAME -c 'yay -Sy --noconfirm wd719x-firmware'       1>/dev/null 2>/dev/null;
runuser -l $USERNAME -c 'yay -Sy --noconfirm aic94xx-firmware'      1>/dev/null 2>/dev/null;
runuser -l $USERNAME -c 'yay -Sy --noconfirm upd72020x-fw'          1>/dev/null 2>/dev/null;
runuser -l $USERNAME -c 'yay -Sy --noconfirm adduser'               1>/dev/null 2>/dev/null;
```

#### Autoriser le SSH
```bash
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config;
```

#### Samba
```
echo "client min protocol = NT1
client max protocol = SMB3" > /etc/samba/smb.conf;
```

#### Services
```bash
clear;
systemctl enable avahi-daemon.service       2>/dev/null;
systemctl enable NetworkManager             2>/dev/null;
systemctl enable sshd                       2>/dev/null;
systemctl enable smb                        2>/dev/null;

#systemctl enable avahi-dnsconfd.service    2>/dev/null;
#systemctl enable ntpd                      2>/dev/null;
#systemctl enable systemd-homed             2>/dev/null;
#systemctl enable systemd-timesyncd.service 2>/dev/null;
#systemctl enable qemu-guest-agent           2>/dev/null;
```


#### Vérifier log
```bash
clear;
dmesg --level 4;
dmesg --level 3;
```



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### VI.Installation de l'environnement Graphique

#### Serveur d'affichage
```bash
clear;
sudo pacman -Sy --noconfirm xorg-server xorg-xinit 1>/dev/null;
sudo pacman -R xf86-video-fbdev;
```

#### XFCE4
```bash
sudo pacman -Sy --noconfirm xfce4 1>/dev/null;
sudo pacman -Sy --noconfirm xfce4-dev-tools 1>/dev/null;
sudo pacman -Sy --noconfirm xfce4-datetime-plugin 1>/dev/null;
sudo pacman -Sy --noconfirm xfce4-whiskermenu-plugin 1>/dev/null;
```
Goodies:
```bash
# sudo pacman -Sy --noconfirm xfce4-goodies 1>/dev/null;
```



| [Xorg](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Serveur_Affichage) | [Environnement Graphique](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Environnements_Graphique) | [Gestionnaire de session](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Gestionnaire_de_connexion) | [APPLET](https://github.com/dexter74/Linux/tree/main/Archlinux/Appz/Applets) | [Drthrax](https://github.com/dexter74/Linux/blob/main/Archlinux/Deploiement/Drthrax.md)

