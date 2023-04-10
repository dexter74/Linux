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
#### Partitionnement
##### NVME
```
DISK=/dev/nvme1n1
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


