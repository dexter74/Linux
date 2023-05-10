--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### <p align='center'> Installation d'Archlinux</p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### I. Création de la VM
```
Contrôleur : VMware PVSCSI
```


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### II. Live CD
Démarrer la machine et taper les commandes suivantes pour permettre l'accès ssh.

###### Langue FR + Mot de pass + Récupérer IP poste
```bash
loadkeys fr;
passwd;
ip add | grep 192.168;
```

###### Connexion en SSH depuis Windows
```
ssh root@<IP du poste>
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### III. Installation du Système
##### Information sur le Disque
````bash
root@archiso ~ # lsblk
#NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
#loop0   7:0    0 706.5M  1 loop /run/archiso/airootfs
#sda     8:0    0    32G  0 disk
#sr0    11:0    1 818.3M  0 rom  /run/archiso/bootmnt
````
