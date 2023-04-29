#### Création du fichier Credentials
```bash
mkdir /etc/credentials;
echo "username=
password=
vers=3.0
file_mode=0777
dir_mode=0777
workgroup=WORKGROUP
_netdev" > /etc/credentials/.smbpassword;

nano /etc/credentials/.smbpassword;
chmod 600 /etc/credentials/.smbpassword;
````

#### Création des Points de montages
````
mkdir /mnt/Download
mkdir /mnt/Video
mkdir /mnt/Home
````

#### Download
```
echo "[Unit]
  Description=Montage du partage Download
  Requires=network-online.target
  After=network-online.service
[Mount]
  What=//192.168.0.3/Download
  Where=/mnt/Download
  Type=cifs
  TimeoutSec=5s
  Options=credentials=/etc/credentials/.smbpassword,x-gvfs-show,uid=0,gid=0
[Install]
  WantedBy=multi-user.target" > /etc/systemd/system/mnt-Download.mount;
```


#### Gestion du service
```
systemctl daemon-reload;
systemctl restart mnt-Download.mount;
systemctl status mnt-Download.mount;
systemctl enable mnt-Download.mount;
systemctl disable mnt-Download.mount;
```
