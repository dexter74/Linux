#### Création du compte FTP
```
sudo adduser ftp --no-create-home;
sudo passwd ftp;
```

#### Installation
```
apt install -y sudo;
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
