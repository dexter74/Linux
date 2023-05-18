---------------------------------------------------------------------------------------------------------------------
## <p align='center'> [Installation d'un serveur FTP / SFTP](https://infoloup.no-ip.org/ftps-vsftpd-debian10/) </p>

---------------------------------------------------------------------------------------------------------------------
#### Pare-Feu

`ftp://Login:Pass@URL:221`
| Regle       | Interne | Port Externe |
| ----------- | ------- | ------------ |
| FTP-Connect | 21      | 221          |
| FTP-Listen  | 12500   | 12500-12550  |




---------------------------------------------------------------------------------------------------------------------
#### Purge de VSFTPD
```
clear;
apt remove --purge -y openssl vsftpd 1>/dev/null;
rm -r /etc/ssl/vsftp 2>/dev/null;
```

#### Installation des paquets
```
clear;
apt install -y sudo openssl vsftpd 1>/dev/null;
```

---------------------------------------------------------------------------------------------------------------------
#### Génération d'un Certificat SSL

###### Définir la configuration du Certificat
```
clear;
PAYS=FR
REGION=Haute-savoie
VILLE=Paris
ORGANISATION=Personnel
FQDN=$(cat /etc/hosts | grep "$HOSTNAME" | cut -c 11-20)
EMAIL=test@tld.com
```

###### Création du Dossier du certificat
```
clear;
mkdir -p /etc/ssl/vsftp;
```

###### Purge Ancien Certificat
```
clear;
rm /etc/ssl/vsftp/vsftpd.pem 2>/dev/null;
```

###### Génération du Certificat
```
clear;
(echo "$PAYS"; echo "$REGION"; echo "$VILLE"; echo "$ORGANISATION"; echo "$ORGANISATION"; echo "$FQDN"; echo "$EMAIL") |  openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/vsftp/vsftpd.pem -out /etc/ssl/vsftp/vsftpd.pem -days 3650 2>/dev/null; 
```

---------------------------------------------------------------------------------------------------------------------
#### Configuration de VSFTPD
##### Sauvegarder Configuration Inital
```
clear;
cp /etc/vsftpd.conf /etc/vsftpd.conf.old;
cat /etc/vsftpd.conf.old > /etc/vsftpd.conf;
```

###### Relance du service FTP
```
clear;
systemctl restart vsftpd;
```


##### Afficher les paramètres
```
clear; 
grep -v "^#" /etc/vsftpd.conf | sort -n; echo "";
```

##### Configuration du FTP (/etc/vsftpd.conf)

###### Edition de la configuration
```bash
clear;
echo "" > /etc/vsftpd.conf;
nano /etc/vsftpd.conf; systemctl restart vsftpd; systemctl status vsftpd;
```

###### FTP
```
####################################################################################
connect_from_port_20=YES
dirmessage_enable=YES
listen_ipv6=NO
listen=YES
local_enable=YES
use_localtime=YES
xferlog_enable=YES
#secure_chroot_dir=/var/run/vsftpd/empty
```

###### Bannière de connexion
```
####################################################################################
# Bannière de connexion #
#########################
ftpd_banner=Bienvenue sur le serveur ftp de Marc Jaffré
```

###### Connexion Anonyme  
```
####################################################################################
# Connexion Anonyme  #
######################
# Autoriser la connexion Anoymement FTP
anonymous_enable=YES

# Autoriser la connexion Anoymement FTPs
allow_anon_ssl=YES

# Autoriser l'envoi
anon_upload_enable=NO

# Autoriser la création de Dossier
anon_mkdir_write_enable=NO

# Autoriser l'écriture
anon_other_write_enable=NO

# ????
anon_world_readable_only=no

# Dossier racine des invités
anon_root=/var/ftp/

# Permission :
# - chmod -R 755 /var/ftp/;
# - chown -R root:ftp /var/ftp/
```

###### Autoriser les utilisateurs locaux de se connecter et d'écrire
```
####################################################################################
# Autoriser les utilisateurs locaux de se connecter et d'écrire #
#################################################################
local_enable=YES
write_enable=YES
local_umask=022
```
###### FTPS
```
####################################################################################
# Configuration FTPS #
######################
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_ciphers=HIGH
ssl_enable=YES
ssl_sslv2=NO
ssl_sslv3=NO
ssl_tlsv1=YES
rsa_cert_file=/etc/ssl/vsftp/vsftpd.pem
rsa_private_key_file=/etc/ssl/vsftp/vsftpd.pem
```

###### Activation du mode passif
```
####################################################################################
# Mode Passif  #
################
# pasv_enable=YES
# pasv_min_port=12500  # La tranche de ports  aléatoires 
# pasv_max_port=12550  # doit être > à 1024
```

---------------------------------------------------------------------------------------------------------------------

##### Création du Groupe FTP (Section en COURS)
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
