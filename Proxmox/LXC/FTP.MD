#### LXC
```
- Taille de Stockage       : 2 Go
- Conteneur Non-privilégié : NON
- Fonctionnalité           : Imbriqués, SMB, NFS
```

#### Packages
```bash
clear;
sudo apt install -y cifs-utils smbclient 1>/dev/null;
```

#### Arborescence
```bash
mkdir -p /mnt/{Download,Music,Video,Video2} 2>/dev/null;
mkdir -p /mnt/Download/Torrent       2>/dev/null;
```

#### FSTAB (Obscolète)
```bash
echo "##################################################################################################################################################
# mount --bind /mnt/Video  /mnt/Upload/Video #
##############################################
# Permission 775 #
##################
#//192.168.0.3/Download          /mnt/Download         cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
#//192.168.0.3/Music             /mnt/Music            cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
#//192.168.0.3/Video             /mnt/Video            cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
#//192.168.0.3/Video2            /mnt/Video2           cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
#//192.168.0.3/Download/Torrent  /mnt/Download/Torrent cifs uid=root,gid=sudo,file_mode=0777,dir_mode=0777,username=marc,password=admin 0 0
##################################################################################################################################################" > /etc/fstab;
```

#### Installer FTP [Guide](http://vsftpd.beasts.org/vsftpd_conf.html)
---------------------------------------------------------------------------------------------------------------------
## <p align='center'> [Installation d'un serveur FTP / SFTP](https://infoloup.no-ip.org/ftps-vsftpd-debian10/) </p>

---------------------------------------------------------------------------------------------------------------------
#### Pare-Feu (OpenWRT)
Le serveur est en mode Passive pour éviter que le client doit ouvrir des ports. 

`ftpes://Drthrax74:D0Ck3R!@proxmox74.ddns.net:21` | `ftpes://Download:HR9mJRR9gjitCj@proxmox74.ddns.net:21`


| Regle       | Port Interne | Port Externe |
| ----------- | ------------ | ------------ |
| FTP-Connect | 21           | 21           |
| FTP-Listen  | 12500-12550  | 12500-12550  |

---------------------------------------------------------------------------------------------------------------------
#### Utilisateur
| Identifiant | Mot de passe   | Permission    |
| ----------- | -------------- | ------------- |
| Download    | HR9mJRR9gjitCj | RWX : Torrent |
| Drthrax74   | D0Ck3R!        | RWX : Tout    |

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
DOMAIN=proxmox74.ddns.net
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

##### Configuration FTP
```
echo "########################################################################
# Cloisonnement de l-utilisateur #
##################################
allow_writeable_chroot=YES
chroot_local_user=YES
chroot_list_enable=NO
#
########################################################################
# Gestion des fichiers #
########################
hide_file={.*,*.nfo,*.sfv,*.txt,*.xlsx,*.jpg,*.rtf,Thumbs.db}
deny_file={*.exe,*.sh,*.private,*.txt} 
#
########################################################################
# Configuration Generale #
##########################
#
# Delai d-attente du client pour la connexion
accept_timeout=60
#
# Prise en charge ASCII (Attack DDOS)
ascii_download_enable=NO
ascii_upload_enable=NO
#
# Contrôle l-origine de la connexion FTP-Data
connect_from_port_20=NO
#
# Supprimer fichier en cas d-echec d-envoi
delete_failed_uploads=YES
#
# Utiliser une liste d-utilisateur  (/etc/vsftpd.user_list)
userlist_enable=NO
#
# Afficher le message de bienvenue du dossier (.message)
dirmessage_enable=YES
#
# Permettre le telechargement
download_enable=YES
#
# Lister le contenu cache (.XXXX) 
force_dot_files=no
#
# Banniere de connexion
ftpd_banner=Bienvenue sur le serveur ftp
#
# Definir les sessions utilisateurs en invitE
guest_enable=NO
#
# Cacher les Proprietes et afficher ftp comme proprietaire
hide_ids=NO
#
# Mode Implicite
implicit_ssl=NO
#
# Ecouter sur l-IPV4
listen=YES
#
# Ecouter sur l-IPV6
listen_ipv6=NO
#
# Autoriser les comptes locaux à se connecter
local_enable=YES
#
# Permission sur les fichiers (Defaut: 077)
local_umask=022
#
# Interdire la methode PORT d-obtention d-une connexion de donnees.
port_enable=YES
#
# Obliger les clients à presenter leur certificat au serveur
require_cert=NO
#
# Reutilisation du certificat
require_ssl_reuse=No
#
# Liste les fichiers avec le Fuseau Local du client
use_localtime=YES
#
# Certificat Valide Requis (Auto-sgine: Marche pas)
validate_cert=NO
#
# Permettre les commandes d-ecritures 
write_enable=YES
#
# Activer la Journalisation et dans un format Standard
xferlog_enable=YES
xferlog_std_format=NO
#
# Mode passive
pasv_enable=YES
pasv_min_port=12500
pasv_max_port=12550
pasv_promiscuous=NO
pasv_addr_resolve=NO
#
########################################################################
# Forcer la connexion SSL #
###########################
force_local_data_ssl=YES
force_local_logins_ssl=YES
#
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
# Prise en charge de l-authentifcation par SSL
ssl_enable=YES
#
# Certificat Requis
ssl_request_cert=YES
#
# Protocoles Autorises
ssl_sslv2=NO
ssl_sslv3=NO
ssl_tlsv1=YES
#
strict_ssl_read_eof=NO
strict_ssl_write_shutdown=NO
#
########################################################################
# Configuration du compte Invite #
##################################
#
# Permettre l-acces SSL (invite)
#allow_anon_ssl=NO
#
#
# Debit Max en Octets
#anon_max_rate=0
#
# Permettre la creation de dossier
#anon_mkdir_write_enable=NO
#
# Racine du compte invite
#anon_root=/var/ftp
#
# Permettre l-ecriture
anon_other_write_enable=NO
#
# Valeur Umask pour la creation de fichier
#anon_umask=077
#
# Permettre l-envoie
#anon_upload_enable=NO
#
# Permettre le telechargement
#anon_world_readable_only=NO
#
# Activer le compte
#anonymous_enable=NO
#
# Changer le proprietaire sur les fichiers envoyes
#chown_uploads=NO
#
# Forcer la connexion SSL
#force_anon_data_ssl=NO
#force_anon_logins_ssl=NO
#
# Demander un mot de passe
#no_anon_password=NO
#
##################################
# mkdir -p /var/ftp;             #
# chmod -R 755 /var/ftp/;        #
# chown -R root:ftp /var/ftp/;   #
##################################
" > /etc/vsftpd.conf; systemctl restart vsftpd;  systemctl status vsftpd | grep "Active:";
```



---------------------------------------------------------------------------------------------------------------------
#### Création des utilisateurs FTP
```
clear;

#######################################################################################################
# Declarer mes Variables #
##########################
COMPTE1=Download
GROUPE1=FTPUSER
CHEMIN1=/mnt/
COMPTE2=Drthrax74
GROUPE2=root
CHEMIN2=/mnt/
PASSWORD1=HR9mJRR9gjitCj
PASSWORD2=D0Ck3R!
shell=/usr/bin/bash

#######################################################################################################
# Arrêt du service FTP
systemctl stop vsftpd;

#######################################################################################################
# Purge des Users
sudo userdel $COMPTE1;
sudo userdel $COMPTE2;

# Purge du Groupe 1
sudo groupdel $GROUPE1;

# Creation du Groupe 1
sudo groupadd $GROUPE1;

sudo useradd --no-create-home $COMPTE1 -G $GROUPE1 --shell $shell;
sudo useradd --no-create-home $COMPTE2 -G $GROUPE2,sudo --no-user-group --system --shell $shell;

#######################################################################################################
# Mot de passe
(echo "$PASSWORD1"; echo "$PASSWORD1") | sudo passwd $COMPTE1;
(echo "$PASSWORD2"; echo "$PASSWORD2") | sudo passwd $COMPTE2;

# Changer le dossier de l'utilisateur
sudo usermod -d $CHEMIN1 $COMPTE1;
sudo usermod -d $CHEMIN2 $COMPTE2;

#######################################################################################################
# Relance du service FTP
systemctl start vsftpd;
#######################################################################################################
```
