------------------------------------------------------------------------------------------------------------------------------------------------

## <p align='center'> .: Installation de Archlinux sous Raspberry 3 :. </p>

------------------------------------------------------------------------------------------------------------------------------------------------

[WIKI](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3)

#### Etape 1: Préparation de la Carte SD

```
Partition 0: 512M en W95 FSTAB32 (LBA)
Partition 1: 31G  en ext4
```

```bash
clear;
sudo umount -R /run/media/$USER/* 2>/dev/null;
sudo lsblk;
sudo cfdisk /dev/mmcblk1;
sudo echo "yes" | mkfs.vfat /dev/mmcblk1p1;
sudo echo "yes" | mkfs.ext4 /dev/mmcblk1p2;
```

#### Etape 2: Monter la partition
```bash
sudo mkdir /mnt/root;
sudo mkdir /mnt/boot;
sudo mount /dev/mmcblk1p1 /mnt/boot;
sudo mount /dev/mmcblk1p2 /mnt/root;
```

#### Etape 3: Installation du Système
```bash
sudo wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-armv7-latest.tar.gz;
sudo bsdtar -xpf ArchLinuxARM-rpi-armv7-latest.tar.gz -C /mnt/root;
sudo sync;
```

#### Etape 4: Partition Boot
```bash
sudo mv /mnt/root/boot/* /mnt/boot;
sudo echo 'LANG=fr_FR.UTF-8'   > /mnt/root/etc/locale.conf;
sudo echo 'KEYMAP=fr-latin9'   > /mnt/root/etc/vconsole.conf;
sudo echo 'FONT=eurlatgr'     >> /mnt/root/etc/vconsole.conf;
sudo echo 'fr_FR.UTF-8 UTF-8'  > /mnt/root/etc/locale.gen;
```

#### Etape 5: Démarrer le Raspberry
```bash
loadkey fr;
iwconfig wlan0 key LaCLEWEP;
wifi-menu -o;
```

#### Etape 6: Mise à jour des clé PGP
```bash
pacman-key --init;
pacman-key --populate archlinuxarm;
```

#### Etape 7: Installation de Package
```bash
pacman -Syu;
pacman -Sy sudo;
pacman -Sy xorg xorg-server xorg-xinit;
pacman -Sy xf86-video-fbdev;
pacman -Sy networkmanager networkmanager-pptp networkmanager-qt network-manager-applet;
pacman -Sy pulseaudio pavucontrol;
pacman -Sy xfce4 xfce4-goodies;
pacman -Sy lightdm lightdm-gtk-greeter;
pacman -Sy accountsservice;
pacman -Sy pambase;
```

#### Log
```
lightdm --test-mode --debug
cat /var/log/Xorg.0.log | grep "EE\|WW"
```

