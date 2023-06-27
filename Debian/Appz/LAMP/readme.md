--------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide d'installation d'un serveur LAMP </p>

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
```
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
```
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

# Téléchargement de PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/$VERSION/phpMyAdmin-$VERSION-all-languages.zip -O /tmp/phpMyAdmin.zip 2>/dev/null;

# Extraction du site dans le dossier Web
unzip /tmp/phpMyAdmin.zip -d $WWW 1>/dev/null;

# Renommage du Dossier
mv $WWW/phpMyAdmin-$VERSION-all-languages/ $WWW/phpmyadmin;
```

### Dépendances:
```bash
apt install php-mysqli 1>/dev/null;
```

### php.ini
#### Augmenter le nombre de requête
Pour permettre une sauvegarde de la Base de donnée, il faut augmenter le nombre de requête autorisé.
```
clear;

PHP_VERSION=7.4
sed -i -e 's/\;max_input_vars = 1000/max_input_vars = 10000/g' /etc/php/$PHP_VERSION/apache2/php.ini
```


### Relance du service Apache
```bash
systemctl restart apache2;
```

### Afficher informations sur la BDD (User et BDD)
```
mysql -u root -padmin -e "SELECT User FROM mysql.user;"
mysql -u root -padmin -e "SHOW DATABASES;"
```
