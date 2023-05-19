---------------------------------------------------------------------------------------------------------------------
## <p align='center'> [Installation d'un serveur FTP / SFTP](https://infoloup.no-ip.org/ftps-vsftpd-debian10/) </p>

---------------------------------------------------------------------------------------------------------------------
#### Pare-Feu
Le serveur est en mode Passive pour éviter que le client doit ouvrir le port 20 et 21 de son côté. (`ftp://Login:Pass@URL:221`

| Regle       | Interne | Port Externe |
| ----------- | ------- | ------------ |
| FTP-Connect | 21      | 221          |
| FTP-Listen  | 12500   | 12500-12550  |

---------------------------------------------------------------------------------------------------------------------
#### Utilisateur
| Identifiant | Mot de passe | Permission |
| ----------- | ------------ | ---------- |
| test        | admin        |
| Drthrax74   | admin        |

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

##### Configuration
```
echo "########################################################################
# Cloisonnement de l'utilisateur #
##################################
chroot_local_user=YES
chroot_list_enable=NO
allow_writeable_chroot=YES

########################################################################
# Forcer la connexion SSL #
###########################
force_local_data_ssl=NO
force_local_logins_ssl=NO

########################################################################
# Configuration Générale #
##########################
#
# Délai d'attente du client pour la connexion
accept_timeout=60
#
# Prise en charge ASCII (Attack DDOS)
ascii_download_enable=NO
ascii_upload_enable=NO
#
# Contrôle l'origine de la connexion FTP-Data
connect_from_port_20=YES
#
# Supprimer fichier en cas d'échec d'envoi
delete_failed_uploads=NO
#
# Permettre le listage de fichier
dirlist_enable=YES
#
# Afficher le message de bienvenue du dossier (.message)
dirmessage_enable=YES
#
# Permettre le téléchargement
download_enable=YES
#
# Lister le contenu caché (.XXXX) 
force_dot_files=NO
#
# Banniere de connexion
ftpd_banner=Bienvenue sur le serveur ftp
#
# Définir les sessions utilisateurs en invité
guest_enable=NO
#
# Cacher les Propriétés et afficher ftp comme propriétaire
hide_ids=NO
#
# Mode Implicite
implicit_ssl=NO
#
# Ecouter sur l'IPV4
listen=YES
#
# Ecouter sur l'IPV6
listen_ipv6=No
#
# Autoriser les comptes locaux à se connecter
local_enable=YES
#
# Permission sur les fichiers (Défaut: 077)
local_umask=022
#
# Interdire la méthode PORT d'obtention d'une connexion de données.
port_enable=YES
#
# Obliger les clients à présenter leur certificat au serveur
require_cert=NO
#
# Réutilisation du certificat
require_ssl_reuse=YES
#
# Liste les fichiers avec le Fuseau Local du client
use_localtime=YES
#
# Certificat Valide Requis (Auto-sginé: Marche pas)
validate_cert=NO
#
# Permettre les commandes d'écritures 
write_enable=YES
#
# Activer la Journalisation et dans un format Standard
xferlog_enable=YES
xferlog_std_format=NO

# Mode passive
pasv_addr_resolve=NO
pasv_enable=YES
pasv_max_port=12500
pasv_min_port=12550
pasv_promiscuous=NO

########################################################################
# Configuration du SSL #
########################
# Mode Debuggage
#debug_ssl=NO
#
# Certificat SSL (Default: /usr/share/ssl/certs/vsftpd.pem)
rsa_cert_file=/etc/ssl/vsftp/vsftpd.pem
rsa_private_key_file=/etc/ssl/vsftp/vsftpd.pem
#
# Type de chiffrement (DES-CBC3-SHA)
ssl_ciphers=HIGH
#
# Prise en charge de l'authentifcation par SSL
ssl_enable=YES
#
# Certificat Requis
#ssl_request_cert=YES
#
# Protocoles Autorisés
ssl_sslv2=NO
ssl_sslv3=NO
ssl_tlsv1=YES
#
strict_ssl_read_eof=NO
strict_ssl_write_shutdown=NO
#

########################################################################
# Configuration du compte Invité #
##################################
#
# Permettre l'accès SSL (invité)
allow_anon_ssl=NO
#
#
# Débit Max en Octets
anon_max_rate=0
#
# Permettre la création de dossier
anon_mkdir_write_enable=NO
#
# Racine du compte invité
anon_root=/var/ftp
#
# Permettre l'écriture
anon_other_write_enable=NO
#
# Valeur Umask pour la création de fichier
anon_umask=077
#
# Permettre l'envoie
anon_upload_enable=NO
#
# Permettre le téléchargement
anon_world_readable_only=NO
#
# Activer le compte
anonymous_enable=NO
#
# Changer le propriétaire sur les fichiers envoyés
chown_uploads=NO
#
# Forcer la connexion SSL
force_anon_data_ssl=NO
force_anon_logins_ssl=NO

# Demander un mot de passe
no_anon_password=NO

##################################
# mkdir -p /var/ftp;             #
# chmod -R 755 /var/ftp/;        #
# chown -R root:ftp /var/ftp/;   #
##################################
" > /etc/vsftpd.conf; systemctl restart vsftpd;
```


---------------------------------------------------------------------------------------------------------------------
#### Création des utilisateurs FTP
```
clear;

###########################################################################
# Déclarer mes Variables #
##########################
COMPTE1=test
GROUPE1=monftp
CHEMIN1=/mnt/Download/Torrent
COMPTE2=Drthrax74
GROUPE2=root
CHEMIN2=/mnt/
PASSWORD=admin
shell=/usr/bin/bash

####################################
# Purge des Users
sudo userdel $COMPTE1 2>/dev/null;
sudo userdel $COMPTE2 2>/dev/null;

# Purge du Groupe 1
sudo groupdel $GROUPE1 2>/dev/null;

# Création du Groupe 1
sudo groupadd $GROUPE1 2>/dev/null;

sudo useradd --no-create-home $COMPTE1 -G $GROUPE1 --shell $shell;
sudo useradd --no-create-home $COMPTE2 -G $GROUPE2,sudo --no-user-group --system --shell $shell;

id $COMPTE2;

# Mot de passe
(echo "$PASSWORD"; echo "$PASSWORD") | sudo passwd $COMPTE1;
(echo "$PASSWORD"; echo "$PASSWORD") | sudo passwd $COMPTE2;

# Changer le dossier de l'utilisateur
sudo usermod -d $CHEMIN1 $COMPTE1;
sudo usermod -d $CHEMIN2 $COMPTE2;

# Définir le groupe principale de l'utilisateur
# sudo usermod -g myftp test;

```

###### Relance du service FTP
```
clear;
systemctl restart vsftpd;
```
