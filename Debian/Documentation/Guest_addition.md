-------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation des Guests Additions dans VirtualBox 7 </p>

-------------------------------------------------------------------------------------------------------------------------------------
### Package dans le dépôt
Le package ne prend en charge que la version 6.0
![image](https://github.com/dexter74/Linux/assets/35907/3015f967-1e55-46a5-824e-85c5414c1041)

-------------------------------------------------------------------------------------------------------------------------------------
### Installation du package sans les dépendances:
### Monter le Lecteur CD-ROM
```bash
clear;
mount /sr0 /media/cdrom0;
```

### Installation du Package VirtualBOX (Sans dépendance)
```
cd /media/cdrom0;
sh *.run;
```
![image](https://github.com/dexter74/Linux/assets/35907/45803d1e-2a3c-4bc0-bfdf-8c4a264f9f09)


### Installation des dépendances
Le package des Guest additions dans le dépôt officiel n'est pas à jour.
```bash
clear;
apt install -y linux-headers-amd64;
```

Refaire l'étape d'installation du Package VirtualBOX.




