---------------------------------------------------------------------------------------------------------------------
<p align='center'> Installation d'un serveur FTP / SFTP </p>

---------------------------------------------------------------------------------------------------------------------
#### Purge de VSFTPD
```
apt remove --purge -y openssl vsftpd;
```

#### Installation des paquets
```
apt install -y sudo openssl vsftpd;
```

---------------------------------------------------------------------------------------------------------------------
#### Génération d'un Certificat SSL

###### Création du Dossier du certificat
```
mkdir -p /etc/ssl-vsftpd/private;
chmod 700 /etc/ssl-vsftpd/private;
```

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

###### Génération du Certificat
```
(echo "$PAYS"; echo "$ETAT"; echo "$CITY"; echo "$ORGA"; echo "$ORGA"; echo "$FQDN"; echo "$EMAIL") | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /etc/ssl-vsftpd/private/vsftpd.pem -out /etc/ssl-vsftpd/private/vsftpd.pem;
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

##### Afficher Paramètre
```
clear; 
grep -v "^#" /etc/vsftpd.conf | sort -n;
```

##### Configuration du FTP (/etc/vsftpd.conf)
```
clear;
echo "
##############################################################
##############################################################
" > /etc/vsftpd.conf; systemctl restart vsftpd;
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
