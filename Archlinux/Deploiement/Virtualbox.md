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
Permet l'accès SSH depuis l'hôte

![image](https://user-images.githubusercontent.com/35907/235335576-9f380bc6-31b5-43a7-a757-a05491d15cfb.png)

--------------------------------------------------------------------------------------------------------------------------------------------
### Installation d'Archlinux
###### Définir le clavier en FR
```bash
loadkeys fr;
```

###### Définir le mot de passe du compte root
```
passwd root;
```
