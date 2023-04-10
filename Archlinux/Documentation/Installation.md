----------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'Archlinux </p>

----------------------------------------------------------------------------------------------------------------------------------------
#### Clavier en Azerty
```bash
loadkeys fr;
```

#### Pacman
```bash
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
sed -i -e "s/\#ParallelDownloads = 5/ParallelDownloads = 10/g" /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
<br />

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
pacstrap /mnt base linux linux-lts
```

#### Pilotes
```bash
pacstrap /mnt amd-ucode broadcom-wl linux-firmware linux-headers ntfs-3g
```

#### Réseaux
```bash
pacstrap /mnt dhclient dhcpcd dnsutils iw iwd net-tools networkmanager networkmanager-pptp networkmanager-qt network-manager-applet wireless-regdb
```

#### Le Son
```bash
pacstrap /mnt pulseaudio pulseaudio-alsa pavucontrol
```

#### Librairies
``` bash
pacstrap /mnt base-devel fakeroot go
```

#### Utilitaires (Ligne de commandes)
``` bash
pacstrap /mnt bash-completion curl git gvfs gvfs-gphoto2 gvfs-mtpgvfs-nfs gvfs-smb lsb-release lvm2 man nano neofetch p7zip smbclient sudo unzip usbutils wget zip
```

#### Fonctions
```bash
pacstrap /mnt logrotate ntp openssh samba tlp tlp-rdw
```

#### Serveur d'affichage
```bash
pacstrap /mnt xorg-server xorg-xinit xf86-video-amdgpu;
```

#### Gestion de la session
```bash
pacstrap /mnt lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-webkit2-greeter
```

#### Environnement Graphique
```bash
pacstrap /mnt xfce4 xfce4-dev-tools xfce4-goodies xfce4-datetime-plugin xfce4-whiskermenu-plugin
```


#### Logiciels Utilisateur
```bash
pacstrap /mnt discord file-roller gnome-{calculator,calendar,font-viewer,terminal} numlockx plank rhythmbox seahorse smplayer virtualbox virtualbox-guest-iso virtualbox-host-modules-arch
```

#### Non Classé
```bash
amdvlk
dpkg
mesa-utils
opencl-mesa
systemd-ui
```


