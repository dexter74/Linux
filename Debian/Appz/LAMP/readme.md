--------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide d'installation d'un serveur LAMP </p>

Protection:
https://wiki.debian.org/fr/Apache/mod_evasive

--------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
**L**inux **A**pache **M**ysql et **P**HP
<br />
--------------------------------------------------------------------------------------------------------------------------------
### I. Configuration de l'environnement
#### A. APT
```bash
clear;
# Commenté la ligne CDROM
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;

# Mise à jour liste des paquets
apt update 1>/dev/null;

# Upgrade des paquets
apt upgrade -y 1>/dev/null;
```

#### B. Configuration des interfaces réseaux
L'interface réseau s'appelle `ens18`.
```bash
echo "#########################################################
# Interface de bouclage #
#########################
auto lo
iface lo inet loopback

#########################################################
# Interface ens18 #
###################
auto ens18
allow-hotplug ens18
iface ens18 inet static
 address        192.168.0.50
 netmask        255.255.255.0
 gateway        192.168.0.1
 dns-nameserver 192.168.0.1
 dns-domain     LAN" >  /etc/network/interfaces

systemctl restart networking;
```
#### B. Relance du service Networking
```bash
systemctl restart networking;
```
--------------------------------------------------------------------------------------------------------------------------------
### III. Paquets de base
```bash
clear;
apt install -y curl  1>/dev/null;
apt install -y unzip 1>/dev/null;
apt install -y wget  1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
### IV. Apache
```bash
clear;
apt install -y apache2 libapache2-mod-php 1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
### V. MariaDB
#### A. Installation
```bash
clear;
PASS_ROOT_SQL=admin
apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASS_ROOT_SQL"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```
#### B. Autoriser l'authentification mysql_native_password
Permettra à PHPMYADMIN d'accèder à la base de donnée depuis le compte root.
```bash
mysql -u root -padmin -e "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
## VI. PHP
#### B. PHP 7
```bash
clear;
apt install -y php 1>/dev/null;
```
### C. Connaitre la version de PHP et de ses Modules
```bash
clear;
apt list --installed | grep php;
```


---------------------------------------------------------------------------------------------------------------------------------------
## VI. Gestionnaire de la Base De Donnée
### PHPMyAdmin
```bash
clear;
VERSION=5.2.1
WWW=/var/www/html

# Dépendance:
apt install php-mysqli 1>/dev/null;

# Téléchargement de PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/$VERSION/phpMyAdmin-$VERSION-all-languages.zip -O /tmp/phpMyAdmin.zip 2>/dev/null;

# Extraction du site dans le dossier Web
unzip /tmp/phpMyAdmin.zip -d $WWW 1>/dev/null;

# Renommage du Dossier
mv $WWW/phpMyAdmin-$VERSION-all-languages/ $WWW/phpmyadmin;
```


#### X. Configuration de php.ini
### Augmenter le nombre de requête
Pour permettre une sauvegarde de la Base de donnée, il faut augmenter le nombre de requête autorisé.
```nash
clear;
PHP_VERSION=7.4
sed -i -e 's/\;max_input_vars = 1000/max_input_vars = 10000/g' /etc/php/$PHP_VERSION/apache2/php.ini
```

### Relance du service Apache
```bash
systemctl restart apache2;
```

### Afficher informations sur la BDD (User et BDD)
```bash
mysql -u root -padmin -e "SELECT User FROM mysql.user;"
mysql -u root -padmin -e "SHOW DATABASES;"
```


---------------------------------------------------------------------------------------------------------------------------------------
## VII. Mise en place du HTTPS
Pour permettre l'accès en HTTPS, il faut générer un certificat SSL puis configurer Apache pour qu'il charge ce certificat.

### X. Installation de OpenSSL
Le paquet OpenSSL permet la génération de certificat de sécurité.
```bash
apt install -y openssl;
```

#### X Création du Certificat SSL
```bash
mkdir /etc/apache2/ssl;
openssl genrsa 4096 > /etc/apache2/ssl/web01.key;
(echo "FR"; echo "France"; echo "Haute-Savoie"; echo "Personnel"; echo "Personnel"; echo "Debian.lan"; echo ""; ) | openssl req -new -key /etc/apache2/ssl/web01.key -x509 -days 365 -out /etc/apache2/ssl/web01.pem;
```

#### X. Création du Virtual Host
```bash
sed -i -e 's/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/\/etc\/apache2\/ssl\/web01.key/g' /etc/apache2/sites-available/default-ssl.conf;
sed -i -e 's/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/\/etc\/apache2\/ssl\/web01.pem/g'   /etc/apache2/sites-available/default-ssl.conf;
```

#### X. Activation des modules SSL
```bash
a2enmod ssl
```

#### X. Activation du site default-ssl.conf
```bash
a2ensite default-ssl
```

#### X. Relance du service Apache
```bash
systemctl reload apache2
```
