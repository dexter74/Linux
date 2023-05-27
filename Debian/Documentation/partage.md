##### I. Credentials
```
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

##### II. Services Mount
```bash
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Download
  Requires=network-online.target
  After=network-online.service

[Mount]
  What=//192.168.1.32/Download
  Where=/mnt/Download
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.mount;
```

##### III. Mise en fonction des services
```
clear;
USERNAME=$(id 1000 | cut -d  ")" -f 1 | cut -d "(" -f 2)
mkdir -p /mnt/Download;
chown -R $USERNAME:users /mnt/Download;
```
```
clear;
systemctl daemon-reload;
systemctl stop  mnt-Download;
systemctl disable --now mnt-Download;

systemctl start mnt-Download;
systemctl enable --now mnt-Download;
systemctl status --now mnt-Download | grep "mount\|Active:" ;
```

