### Création d'un compte Utilisateur Linux
```bash
#########################################################################################################
# Nettoyage de la console #
###########################
clear;

#########################################################################################################
# Déclaration des variables #
#############################
# Nom d'utilisateur et mot de passe du compte:
export UTILISATEUR=Drthrax74
export PASSWORD=admin
export USERID=1001

#########################################################################################################
# Création du compte #
######################
/usr/sbin/useradd \
--home-dir /home/$UTILISATEUR \
--base-dir /home/$UTILISATEUR \
--uid $USERID \
--no-user-group \
--shell /bin/bash \
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
UTILISATEUR="Drthrax74@pam"
MOTDEPASSE="admin"
EMAIL="teste74@hotmail.fr"
PRENOM="Marc"
NOM="Jaffre"

# Purge
sudo pveum group del   Administrateurs 2>/dev/null;
sudo pveum group del   Audit 2>/dev/null;
sudo pveum group del   Stockage 2>/dev/null;
sudo pveum group del   Utilisateurs 2>/dev/null;
sudo pveum group del   VMadmin  2>/dev/null;
sudo pveum pool del    100.LXC;
sudo pveum pool del    200.Linux;
sudo pveum pool del    300.Windows;
sudo pveum pool del    400.Templates;
sudo pveum user delete $UTILISATEUR 2>/dev/null;

# Création des Groupes:
sudo pveum group add Administrateurs -comment "Groupe des administrateurs"
sudo pveum group add Audit           -comment "Groupe des auditeurs"
sudo pveum group add Stockage        -comment "Groupe du stockage"
sudo pveum group add Utilisateurs    -comment "Groupe des utilisateurs"
sudo pveum group add VMadmin         -comment "Groupe des Admins des VM"

# Création des Pools:
sudo pveum pool add 100.LXC;
sudo pveum pool add 200.Linux;
sudo pveum pool add 300.Windows;
sudo pveum pool add  400.Templates;

# Création Utilisateur
sudo pveum user add "$UTILISATEUR" -email "$EMAIL" -enable 1 -first "$PRENOM" -lastname "$NOM";

# Changement du mot de passe:
(echo "$MOTDEPASSE"; echo "$MOTDEPASSE") | sudo pveum passwd $UTILISATEUR

# Modification des permissions pour les groupes
sudo pveum acl modify / -group Administrateurs -role Administrator;
sudo pveum acl modify / -group Audit -role PVEAuditor;
sudo pveum acl modify / -group Stockage -role PVEDatastoreAdmin;
sudo pveum acl modify / -group Utilisateurs -role PVEVMUser;
sudo pveum acl modify / -group VMadmin -role PVEVMAdmin;

# Modification permission de l'utilisateur
sudo pveum user modify "$UTILISATEUR" -group Administrateurs;
```

<br />

----------------------------------------------------------------------------------------------------------------------------------
### Partage

```bash
mkdir /etc/credentials;

echo "username=
password=
vers=3.0
file_mode=0777
dir_mode=0777
workgroup=WORKGROUP
_netdev" > /etc/credentials/.smbpassword;

chmod 600 /etc/credentials/.smbpassword;
nano /etc/credentials/.smbpassword;
```

```bash
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Download
  Requires=remote-fs-pre.target
  After=network-online.service

[Mount]
  What=//192.168.0.3/Download
  Where=/mnt/Download
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.mount;
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Music
  Requires=
  
  After=network-online.service

[Mount]
  What=//192.168.0.3/Music
  Where=/mnt/Music
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Music.mount;
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Video
  Requires=remote-fs-pre.target
  After=network-online.service

[Mount]
  What=//192.168.0.3/Video
  Where=/mnt/Video
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video.mount;
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Home
  Requires=remote-fs-pre.target
  After=network-online.service

[Mount]
  What=//192.168.0.3/Home
  Where=/mnt/Home
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Home.mount;
####################################################################################################################################
```

#### Dossier, Permission et services
```bash
clear;
USERNAME=$(id 1000 | cut -d  ")" -f 1 | cut -d "(" -f 2)
mkdir -p /mnt/{Download,Home,Music,Video};
chown -R $USERNAME:users /mnt/{Download,Home,Music,Video};

# Pre-requis:
systemctl enable systemd-networkd-wait-online.service;

systemctl daemon-reload;
systemctl stop  mnt-{Download,Home,Music,Video}.mount;
systemctl disable --now mnt-{Download,Home,Music,Video}.mount;

systemctl start mnt-{Download,Home,Music,Video}.mount;
systemctl enable --now mnt-{Download,Home,Music,Video}.mount;
systemctl status --now mnt-{Download,Home,Music,Video}.mount | grep "mount\|Active:";
```

#### French
```
echo "language: fr" >> /etc/pve/datacenter.cfg;
systemctl restart pveproxy.service;

# /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
```

#### Attacher Disque-Dur physique à une VM
Une fois Ajouter, il faut éditer le Disque pour empêcher la sauvegarde de celui-ci.
```
qm shutdown 300;
qm unlink 300 --idlist sata1;
qm unlink 300 --idlist sata2;

qm set 300 -sata1 /dev/sda;
qm set 300 -sata2 /dev/nvme0n1p1;

qm start 300;
```

