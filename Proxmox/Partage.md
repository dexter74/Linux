----------------------------------------------------------------------------------------------------------------------------------
### Présentation
```
Les partages sont montés en Root.
L'utilisateur et Groupe Root ont toutes les permissions
Les autres utilisateurs ne peuvent que Lire.
```

----------------------------------------------------------------------------------------------------------------------------------
### Paquets Nécessaire
```bash
clear;
sudo apt install -y samba samba-common 1>/dev/null;
sudo apt install -y cifs-utils         1>/dev/null;
sudo apt install -y smbclient          1>/dev/null;
```

----------------------------------------------------------------------------------------------------------------------------------
### Partage
```bash
  # ,x-gvfs-show,uid=0,gid=0
  # ,file_mode=0775,dir_mode=0775,
  # _netdev
  # ,acl
  # ,user_xattr
```

```bash
clear;
mkdir /etc/credentials 2>/dev/null;
echo "username=marc
password=admin" > /etc/credentials/.smbpassword; chmod 600 /etc/credentials/.smbpassword;

#nano /etc/credentials/.smbpassword;
```


----------------------------------------------------------------------------------------------------------------------------------
**CIFS** (Windows)
```bash
#####################################################################################################
# Nettoyage de la console #
###########################
clear;

#####################################################################################################
# Montage du Partage Download #
###############################
echo "[Unit]
  Description=Montage du partage Download
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Download
  Where=/mnt/Download
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.mount;

#####################################################################################################
# Montage du Partage Home #
###########################
echo "[Unit]
  Description=Montage du partage Home
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Home
  Where=/mnt/Home
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Home.mount;

#####################################################################################################
# Montage du Partage Music #
############################
echo "[Unit]
  Description=Montage du partage Music
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Music
  Where=/mnt/Music
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Music.mount;

#####################################################################################################
# Montage du Partage Video #
############################
echo "[Unit]
  Description=Montage du partage Video
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Video
  Where=/mnt/Video
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video.mount;

#####################################################################################################
# Montage du Partage Video2 #
#############################
echo "[Unit]
  Description=Montage du partage Video2
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Video2
  Where=/mnt/Video2
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video2.mount;

#####################################################################################################
# Montage du Partage Windows #
##############################
echo "[Unit]
  Description=Montage du partage Windows
  Requires=remote-fs-pre.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Windows
  Where=/mnt/Windows
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,cifsacl
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Windows.mount;
```

----------------------------------------------------------------------------------------------------------------------------------
#### Dossier, Permission et services
```bash
clear;
# Pre-requis
systemctl enable systemd-networkd-wait-online.service;
systemctl daemon-reload;

# Dossier
USERNAME=$(id 1000 | cut -d  ")" -f 1 | cut -d "(" -f 2)
mkdir -p /mnt/{Download,Home,Music,Video,Video2,Windows} 2>/dev/nulll;

# Arrêter Service
systemctl stop  mnt-{Download,Home,Music,Video,Video2,Windows}.mount 2>/dev/null;
systemctl disable --now mnt-{Download,Home,Music,Video,Video2,Windows}.mount 2>/dev/null;

# Editer Permission
chown -R $USERNAME:users /mnt/{Download,Home,Music,Video,Video2,Windows};

# Lancer le Service
systemctl start mnt-{Download,Home,Music,Video,Video2,Windows}.mount;
systemctl enable --now mnt-{Download,Home,Music,Video,Video2,Windows}.mount 2>/dev/null;
```

----------------------------------------------------------------------------------------------------------------------------------
#### Vérification
```bash
clear;
df -h /mnt/Home /mnt/Download /mnt/Video /mnt/Video2 /mnt/Music /mnt/Windows;
ls -la /mnt;
```

----------------------------------------------------------------------------------------------------------------------------------
##### Relance FTP
```bash
clear;
systemctl restart vsftpd.service
```
