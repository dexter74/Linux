#### Purge de VSFTPD
```
apt remove --purge -y vsftpdvsftpd.conf;
```

#### Installation du FTP
```
apt install -y sudo openssl vsftpd;
```

#### Sauvegarder Configuration Inital
```
cp /etc/vsftpd.conf /etc/vsftpd.conf.old
```

#### Editer la configuration
```
nano /etc/vsftpd.conf;
```
