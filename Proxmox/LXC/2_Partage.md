#### Host
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

clear;
USERNAME=$(id 1000 | cut -d  ")" -f 1 | cut -d "(" -f 2)
mkdir -p /mnt/{Download,Home,Music,Video};
chown -R $USERNAME:users /mnt/{Download,Home,Music,Video};

clear;
systemctl daemon-reload;
systemctl stop  mnt-{Download,Home,Music,Video}.mount;
systemctl disable --now mnt-{Download,Home,Music,Video}.mount;

systemctl start mnt-{Download,Home,Music,Video}.mount;
systemctl enable --now mnt-{Download,Home,Music,Video}.mount;
systemctl status --now mnt-{Download,Home,Music,Video}.mount | grep "mount\|Active:" ;
```



#### LXC
```
nano /etc/pve/lxc/101.conf
mp0: /mnt/Download,mp=/mnt/Download
mp1: /mnt/Home,mp=/mnt/Home
mp2: /mnt/Music,mp=/mnt/Music
mp3: /mnt/Video,mp=/mnt/Video
```
