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
### Installation ArchLinux
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
mount -R -f /mnt /mnt/*;
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
echo "yes" | pvcreate ${DISK}2;
echo "yes" | vgcreate $VG ${DISK}2;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $VG;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $VG;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $VG;
echo "yes" | mkfs.fat -F32 ${DISK}1;
echo "yes" | mkswap /dev/$VG/SWAP;
echo "yes" | mkfs -t ext4 /dev/$VG/SYSTEM;
echo "yes" | mkfs -t ext4 /dev/$VG/HOME;
swapon /dev/$VG/SWAP;
mount /dev/$VG/SYSTEM /mnt;
mkdir -p /mnt/home && mount /dev/$VG/HOME /mnt/home;
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot;
```
