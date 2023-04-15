##### I. Credentials
```
sudo mkdir /etc/credentials;

echo "username=
password=
vers=3.0
file_mode=0777
dir_mode=0777
workgroup=WORKGROUP
_netdev" > /etc/credentials/.smbpassword;

sudo chmod 600 /etc/credentials/.smbpassword;
sudo nano /etc/credentials/.smbpassword;
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
sudo echo "[Unit]
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
sudo echo "[Unit]
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
sudo echo "[Unit]
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
sudo mkdir -p /mnt/{Download,Home,Music,Video};
sudo chown -R $USERNAME:users /mnt/{Download,Home,Music,Video};
```
```
clear;
sudo systemctl daemon-reload;
sudo systemctl stop  mnt-{Download,Home,Music,Video}.mount;
sudo systemctl disable --now mnt-{Download,Home,Music,Video}.mount;

sudo systemctl start mnt-{Download,Home,Music,Video}.mount;
sudo systemctl enable --now mnt-{Download,Home,Music,Video}.mount;
sudo systemctl status --now mnt-{Download,Home,Music,Video}.mount | grep "mount\|Active:" ;
```




##### IV. Services Automounts
```bash
####################################################################################################################################
sudo echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Music
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Music.automount;
####################################################################################################################################
sudo echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Video
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Video.automount;
####################################################################################################################################
sudo echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service

[Automount]
  Where=/mnt/Home
  TimeoutIdleSec=5

[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Home.automount;
####################################################################################################################################
sudo echo "[Unit]
  Description=cifs mount script
  Requires=network-online.target
  After=network-online.service
  
[Automount]
  Where=/mnt/Download
  TimeoutIdleSec=5
  
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.automount;
```
