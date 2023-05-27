##### I. Credentials
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


```
clear;

###############################
# Information serveur Partage #
###############################
# IP du Serveur
SHARE_IP=

# Identifiant du partage
SHARE_USER=

# Mot de passe
SHARE_PASS=

# Nom des partages
SHARE_SMB1=
SHARE_SMB2=
SHARE_SMB3=

#####################
# Utilisateur Local #
#####################
# Récupération ID 1000 (User + Group)
LOCAL_USER=$(id 1000  | cut -d ")" -f 1 | cut -d "(" -f 2)
LOCAL_GROUP=$(id 1000 | cut -d "(" -f 2 | cut -d ")" -f 1)


####################################
# Création des dossiers de montage #
####################################
mkdir -p /mnt/$SHARE_SMB1;
mkdir -p /mnt/$SHARE_SMB2;
mkdir -p /mnt/$SHARE_SMB3;

###############
# Permissions #
###############
chown -R $USERNAME:$LOCAL_GROUP /mnt/$SHARE_SMB1;
chown -R $USERNAME:$LOCAL_GROUP /mnt/$SHARE_SMB2;
chown -R $USERNAME:$LOCAL_GROUP /mnt/$SHARE_SMB3;
```

##### II. Services Mount
```bash
echo "[Unit]
  Description=Montage du partage $SHARE_SMB1
  Requires=network-online.target
  After=network-online.service

[Mount]
  What=//$SHARE_IP/$SHARE_SMB1
  Where=/mnt/$SHARE_SMB1
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=$LOCAL_USER,gid=$LOCAL_GROUP

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-$SHARE_SMB1.mount;
```

```
clear;
systemctl daemon-reload;
systemctl stop  mnt-$SHARE_SMB1;
systemctl disable --now mnt-$SHARE_SMB1;

systemctl start mnt-Download;
systemctl enable --now mnt-$SHARE_SMB1;
systemctl status --now mnt-$SHARE_SMB1 | grep "mount\|Active:" ;
```

