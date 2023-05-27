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
```
username=
password=
vers=3.0
sec=ntlmv2
file_mode=0777
dir_mode=0777
workgroup=WORKGROUP
uid=1000
gid=984
x-systemd.device-timeout=5s
x-systemd.idle-timeout=5s
x-gvfs-show
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
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Music
  Requires=network-online.target
  After=network-online.service

[Mount]
  What=//192.168.1.32/Music
  Where=/mnt/Music
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Music.mount;
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Video
  Requires=network-online.target
  After=network-online.service

[Mount]
  What=//192.168.1.32/Video
  Where=/mnt/Video
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video.mount;
####################################################################################################################################
echo "[Unit]
  Description=Montage du partage Home
  Requires=network-online.target
  After=network-online.service

[Mount]
  What=//192.168.1.32/Home
  Where=/mnt/Home
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=1000,gid=984

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Home.mount;
####################################################################################################################################
```

##### III. Mise en fonction des services
```
clear;
USERNAME=$(id 1000 | cut -d  ")" -f 1 | cut -d "(" -f 2)
mkdir -p /mnt/{Download,Home,Music,Video};
chown -R $USERNAME:users /mnt/{Download,Home,Music,Video};
```
```
clear;
systemctl daemon-reload;
systemctl stop  mnt-{Download,Home,Music,Video}.mount;
systemctl disable --now mnt-{Download,Home,Music,Video}.mount;

systemctl start mnt-{Download,Home,Music,Video}.mount;
systemctl enable --now mnt-{Download,Home,Music,Video}.mount;
systemctl status --now mnt-{Download,Home,Music,Video}.mount | grep "mount\|Active:" ;
```




##### IV. Services Automounts
```bash
####################################################################################################################################
echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Music
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Music.automount;
####################################################################################################################################
echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Video
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video.automount;
####################################################################################################################################
echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Home
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Home.automount;
####################################################################################################################################
echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service
  
[Automount]
  Where=/mnt/Download
  TimeoutIdleSec=5
  
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.automount;
```
