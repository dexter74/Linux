### Création d'un compte Utilisateur Linux
```bash
#########################################################################################################
# Nettoyage de la console #
###########################
clear;

#########################################################################################################
# Déclaration des variables #
#############################
# Nom d'utilisateur et mot de passe du compte
export UTILISATEUR=Drthrax74
export PASSWORD=admin
export USERID=1001
export SHELL=/bin/bash

#########################################################################################################
# Création du compte #
######################
/usr/sbin/useradd \
--home-dir /home/$UTILISATEUR \
--base-dir /home/$UTILISATEUR \
--uid $USERID \
--no-user-group \
--shell $SHELL \
--create-home $UTILISATEUR;

#########################################################################################################
# Définir le mot de passe du compte #
#####################################
(echo "$UTILISATEUR:$PASSWORD") | chpasswd;

#########################################################################################################
# Sudoers son utilisateur #
###########################
# echo "$UTILISATEUR ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$UTILISATEUR;

#########################################################################################################
# Vérification #
################
id $UTILISATEUR;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------

### Création d'un compte Utilisateur Proxmox
```bash
clear;
UTILISATEUR="Drthrax74@pam"
MOTDEPASSE="admin"
EMAIL="teste74@hotmail.fr"
PRENOM="Marc"
NOM="Jaffre"

# Purge
sudo pveum group del   Administrateurs 2>/dev/null;
sudo pveum group del   Audit           2>/dev/null;
sudo pveum group del   Stockage        2>/dev/null;
sudo pveum group del   Utilisateurs    2>/dev/null;
sudo pveum group del   VMadmin         2>/dev/null;
sudo pveum pool del    100.LXC         2>/dev/null;
sudo pveum pool del    200.Linux       2>/dev/null;
sudo pveum pool del    300.Windows     2>/dev/null;
sudo pveum pool del    400.Templates   2>/dev/null;
sudo pveum pool del    500.invites     2>/dev/null;
sudo pveum user delete $UTILISATEUR    2>/dev/null;

# Création des Groupes:
sudo pveum group add Administrateurs -comment "Groupe des administrateurs";
sudo pveum group add Audit           -comment "Groupe des auditeurs";
sudo pveum group add Stockage        -comment "Groupe du stockage";
sudo pveum group add Utilisateurs    -comment "Groupe des utilisateurs";
sudo pveum group add VMadmin         -comment "Groupe des Admins des VM";

# Création des Pools:
sudo pveum pool add 100.LXC;
sudo pveum pool add 200.Linux;
sudo pveum pool add 300.Windows;
sudo pveum pool add 400.Templates;
sudo pveum pool add 500.invites;

# Création Utilisateur
sudo pveum user add "$UTILISATEUR" -email "$EMAIL" -enable 1 -first "$PRENOM" -lastname "$NOM";

# Changement du mot de passe:
(echo "$MOTDEPASSE"; echo "$MOTDEPASSE") | sudo pveum passwd $UTILISATEUR;

# Modification des permissions pour les groupes
sudo pveum acl modify / -group Administrateurs -role Administrator;
sudo pveum acl modify / -group Audit           -role PVEAuditor;
sudo pveum acl modify / -group Stockage        -role PVEDatastoreAdmin;
sudo pveum acl modify / -group Utilisateurs    -role PVEVMUser;
sudo pveum acl modify / -group VMadmin         -role PVEVMAdmin;

# Modification permission de l'utilisateur
sudo pveum user modify "$UTILISATEUR"          -group Administrateurs;
```

#### French
```bash
clear;
echo "language: fr" >> /etc/pve/datacenter.cfg;
systemctl restart pveproxy.service;

# /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
```

#### Dépôt (Grauit) 
```
sed -i -e 's/pve-enterprise/pve-no-subscription/g' /etc/apt/sources.list.d/pve-enterprise.list;
sed -i -e 's/enterprise/download/g' /etc/apt/sources.list.d/pve-enterprise.list;

# wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-buster.gpg;
# apt install ca-certificates
```
<br />


### WakeOkLna
```
# Récupérer l'adresse Mac:
ip add show vmbr0 | grep ether | cut -d "r" -f 2 | cut -d " " -f 2;

# Aller dans le Noeud puis sur Systèmes puis Options
# Editer "Adresse MAC pour le Wake-On-LAN"  (04:d9:f5:82:2c:96)
```


--------------------------------------------------------------------------------

#### [Serveur Samba](https://github.com/dexter74/Linux/blob/main/Proxmox/samba.md)
#### [Monter Partage](https://github.com/dexter74/Linux/blob/main/Proxmox/Partage.md)
#### [VFIO](https://github.com/dexter74/Linux/blob/main/Proxmox/VFIO/GUIDE.MD)
#### [Scripts](https://github.com/dexter74/Linux/tree/main/Proxmox/script)
#### [FTP](https://github.com/dexter74/Linux/tree/main/Debian/Appz/FTP)
<br />
