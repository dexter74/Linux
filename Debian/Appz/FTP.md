---------------------------------------------------------------------------------------------------------------------
## <p align='center'> [Installation d'un serveur FTP / SFTP](https://infoloup.no-ip.org/ftps-vsftpd-debian10/) </p>

---------------------------------------------------------------------------------------------------------------------
#### Purge de VSFTPD
```
apt remove --purge -y openssl vsftpd;
rm -r /etc/ssl/vsftp 2>/dev/null;
```

#### Installation des paquets
```
apt install -y sudo openssl vsftpd;
```

---------------------------------------------------------------------------------------------------------------------
#### Génération d'un Certificat SSL

###### Définir la configuration du Certificat
```
PAYS=FR
REGION=Haute-savoie
VILLE=Paris
ORGANISATION=Personnel
FQDN=$(cat /etc/hosts | grep "$HOSTNAME" | cut -c 11-20)
EMAIL=test@tld.com
```

###### Création du Dossier du certificat
```
mkdir -p /etc/ssl/vsftp;
```

###### Purge Ancien Certificat
```
rm /etc/ssl/vsftp/vsftpd.pem 2>/dev/null;
```

###### Génération du Certificat
```
(echo "$PAYS"; echo "$REGION"; echo "$VILLE"; echo "$ORGANISATION"; echo "$ORGANISATION"; echo "$FQDN"; echo "$EMAIL") |  openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/vsftp/vsftpd.pem -out /etc/ssl/vsftp/vsftpd.pem -days 3650; 
```
###### Relance du service FTP
```
systemctl restart vsftpd;
```

---------------------------------------------------------------------------------------------------------------------
#### Configuration de VSFTPD
##### Sauvegarder Configuration Inital
```
cp /etc/vsftpd.conf /etc/vsftpd.conf.old;
cat /etc/vsftpd.conf.old > /etc/vsftpd.conf;
```

##### Afficher les paramètres
```
clear; 
grep -v "^#" /etc/vsftpd.conf | sort -n;
```

##### Configuration du FTP (/etc/vsftpd.conf)
```
clear;
echo "
####################################################################################
# Connexion Anonyme  (Defaut: chmod -R 755 /var/ftp/; chown -R root:ftp /var/ftp/)
anon_root=/var/ftp/
allow_anon_ssl=YES
anonymous_enable=YES
anon_mkdir_write_enable=NO
anon_upload_enable=NO
anon_other_write_enable=NO
####################################################################################
# Write:
write_enable=yes
#chroot_local_user=yes
####################################################################################
# FTP
connect_from_port_20=YES
dirmessage_enable=YES
listen_ipv6=NO
listen=YES
local_enable=YES
#secure_chroot_dir=/var/run/vsftpd/empty
use_localtime=YES
xferlog_enable=YES
####################################################################################
# SFTP
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_ciphers=HIGH
ssl_enable=YES
ssl_sslv2=NO
ssl_sslv3=NO
ssl_tlsv1=YES
rsa_cert_file=/etc/ssl/vsftp/vsftpd.pem
rsa_private_key_file=/etc/ssl/vsftp/vsftpd.pem
####################################################################################
# Activation du mode passif
# pasv_enable=YES
# pasv_min_port=12500  # La tranche de ports  aléatoires 
# pasv_max_port=12550  # doit être > à 1024
####################################################################################
#ascii_upload_enable=YES
#ascii_download_enable=YES
####################################################################################" > /etc/vsftpd.conf;
systemctl restart vsftpd;
systemctl status vsftpd;
```


##### Création du Groupe FTP
```
sudo groupadd sftp_users
```

##### Ajouter l'utilisateur au groupe
```
sudo usermod -g sftp_users marc
```

##### Changer le dossier de l'utilisateur
```
sudo usermod -d /home/marc marc
```
