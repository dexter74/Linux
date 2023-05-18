#### /etc/passwd
```
ftp:x:106:115:ftp daemon,,,:/srv/ftp:/usr/sbin/nologin
```

#### Installation
```
apt install -ysudo;
apt install -y vsftpd;

```

#### Dossier ftp
```
mkdir /opt/ftp
sudo usermod -d /opt/ftp ftp;
systemctl restart vsftpd
```



