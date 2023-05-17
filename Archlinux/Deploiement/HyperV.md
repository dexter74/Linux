---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'>    Installation d'Archlinux sur l'hyperviseur Hyper-V de Microsoft    </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### I. Création de la Machine Virtuelles ([WIKI](https://wiki.archlinux.org/title/Hyper-V#Virtual_machine_creation))
```
Pour les machines de Génération 2, le démarrage à partir d’un lecteur de CD/DVD physique n’est pas pris en charge.
```
<br />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### II Pré-install

###### LiveCD
```bash
loadkeys fr;
(echo "admin"; echo "admin") | passwd;
```

#### Connexion en SSH depuis Windows
Pour facilité l'installation d'archlinux, l'utilisation d'un accès distant SSH permettra de faire des copier/coller.
```
ssh root@192.168.
```


#### Gestion du Disque-Dur
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
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "136"; echo "w") | fdisk $DISK; # LVM
partprobe ${DISK}2;
```
