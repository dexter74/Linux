### Installation du package sans les dépendances:
![image](https://github.com/dexter74/Linux/assets/35907/45803d1e-2a3c-4bc0-bfdf-8c4a264f9f09)

### Installation des dépendances
Le package des Guest additions dans le dépôt officiel n'est pas à jour.
```bash
clear;
apt install -y linux-headers-amd64;
```

### Installer les Guests Additions
```bash
clear;
mount /sr0 /media/cdrom0;
cd /media/cdrom0;
sh *.run;
```



