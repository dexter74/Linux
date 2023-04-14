------------------------------------------------------------------------------------------------------------------------------------------------

## <p align='center'> .: Installation de Archlinux sous Raspberry 3 :. </p>

------------------------------------------------------------------------------------------------------------------------------------------------

#### Etape 1: Préparation de la Carte SD
```
lsblk
cfdisk /dev/mmcblk1

# Partition 0: 512M en W95 FSTAB32 (LBA)
# Partition 1: 31G  en ext4

mkfs.vfat /dev/mmcblk1p1
mkfs.ext4 /dev/mmcblk1p2
```

#### Etape 2: Monter la partition
```
mkdir /mnt/root
mkdir /mnt/boot

mount /dev/mmcblk1p1 /mnt/boot
mount /dev/mmcblk1p2 /mnt/root

df -h
```
