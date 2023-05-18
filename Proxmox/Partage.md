
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

**CIFS** (Windows)
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
systemctl status       mnt-{Download,Home,Music,Video}.mount | grep "mount\|Active:";
```
