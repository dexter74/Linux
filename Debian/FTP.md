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
grep -v "^#" /etc/vsftpd.conf | sort -n;
```

##### Configuration du FTP (/etc/vsftpd.conf)
```
echo "##############################################################
anonymous_enable=NO
connect_from_port_20=YES
dirmessage_enable=YES
listen_ipv6=YES
listen=NO
local_enable=YES
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
secure_chroot_dir=/var/run/vsftpd/empty
ssl_enable=NO
use_localtime=YES
xferlog_enable=YES
##############################################################" > /etc/vsftpd.conf
```

