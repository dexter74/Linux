#### /etc/passwd
```
ftp:x:106:115:ftp daemon,,,:/srv/ftp:/usr/sbin/nologin
```

#### Installation
```
apt install -ysudo;
apt install -y vsftpd;
```

#### Dossier Racine ftp
```
mkdir /opt/ftp
sudo usermod -d /opt/ftp ftp;
systemctl restart vsftpd;
```

#### Dossier Projet 
```
mkdir /opt/ftp/projet;
```

#### Editer configuration
```
cp /etc/vsftpd.conf /etc/vsftpd.conf.old

nano /etc/vsftpd.conf;

local_enable=YES;
write_enable=YES;
chroot_local_user=YES;
```
