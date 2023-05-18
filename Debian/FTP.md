---------------------------------------------------------------------------------------------------------------------
<p align='center'> Installation d'un serveur FTP / SFTP </p>

---------------------------------------------------------------------------------------------------------------------
#### Purge de VSFTPD
```
apt remove --purge -y vsftpdvsftpd.conf;
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
ETAT=France
CITY=Paris
ORGA=Personnel
FQDN=$(cat /etc/hosts | grep "$HOSTNAME" | cut -c 11-20)
EMAIL=test@tld.com
```

###### Purge Ancien Certificat
```
/etc/ssl-vsftpd/private/vsftpd.pem 2>/dev/null;
```

###### Création du Dossier du certificat
```
mkdir -p /etc/ssl-vsftpd/private;
chmod 700 /etc/ssl-vsftpd/private;
```

###### Génération du Certificat
```
(echo "$PAYS"; echo "$ETAT"; echo "$CITY"; echo "$ORGA"; echo "$ORGA"; echo "$FQDN"; echo "$EMAIL") | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /etc/ssl-vsftpd/private/vsftpd.pem -out /etc/ssl-vsftpd/private/vsftpd.pem;
```

---------------------------------------------------------------------------------------------------------------------
#### Configuration de VSFTPD
##### Sauvegarder Configuration Inital
```
cp /etc/vsftpd.conf /etc/vsftpd.conf.old;
cat /etc/vsftpd.conf.old > /etc/vsftpd.conf;
```

##### Afficher Paramètre
```
clear; 
grep -v "^#" /etc/vsftpd.conf | sort -n;
```

##### Configuration du FTP (/etc/vsftpd.conf)
```
clear;
echo "##############################################################
allow_anon_ssl=NO
anonymous_enable=NO
connect_from_port_20=YES
dirmessage_enable=YES
force_local_data_ssl=YES
force_local_logins_ssl=YES
listen_ipv6=NO
listen=NO
local_enable=YES
local_umask=022
pam_service_name=vsftpd
require_ssl_reuse=NO
rsa_cert_file=/etc/ssl-vsftpd/private/vsftpd.pem
secure_chroot_dir=/var/run/vsftpd/empty
ssl_enable=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
ssl_ciphers=HIGH
use_localtime=YES
xferlog_enable=YES
write_enable=YES
##############################################################" > /etc/vsftpd.conf;
systemctl restart vsftpd;
```

