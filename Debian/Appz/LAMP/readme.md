--------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide d'installation d'un serveur LAMP </p>

--------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
**L**inux **A**pache **M**ysql et **P**HP
<br />
```bash
clear;

# Commenté la ligne CDROM
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;

# Mise à jour liste des paquets
apt update;

# Upgrade des paquets
apt upgrade -y;
```

--------------------------------------------------------------------------------------------------------------------------------
## II. Installation des Paquets de base
```bash
clear;
apt install -y curl  1>/dev/null;
apt install -y unzip 1>/dev/null;
apt install -y wget  1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
## III. Apache
```bash
clear;
apt install -y apache2 1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
### IV. MariaDB
```bash
clear;
PASS_ROOT_SQL=admin

apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASS_ROOT_SQL"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
## V. PHP
#### A. PHP 7
```bash
apt install -y php 1>/dev/null;
```

#### B. PHP 8 (Sans passer sous BookWorm)
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list; apt update 1>/dev/null;
apt install -y php;
```

### C. Connaitre la version de PHP et de ses Modules
```
clear;
apt list --installed | grep php;
```


---------------------------------------------------------------------------------------------------------------------------------------
## VI. Gestionnaire de la Base De Donnée
### Dépendances:
```bash
apt install php-mysqli;
```

### PHPMyAdmin
```bash
clear;
VERSION=5.2.1
WWW=/var/www/html

# Téléchargement de PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/$VERSION/phpMyAdmin-$VERSION-all-languages.zip -O /tmp/phpMyAdmin.zip;

# Extraction du site dans le dossier Web
unzip /tmp/phpMyAdmin.zip -d $WWW

# Renommage du Dossier
mv $WWW/phpMyAdmin-$VERSION-all-languages/  $WWW/phpmyadmin;
```


---------------------------------------------------------------------------------------------------------------------------------------
## VII. Optionnel (PHP 8)
Passage au source de Bookworm car certains module php sont absent de bullseye.
```
clear;

# Commenté la ligne CDROM
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;

# Remplacer bullseye par bookworm
sed -i -e 's/bullseye/bookworm/g'     /etc/apt/sources.list;

# Mise à jour liste des paquets
apt update;

# Upgrade des paquets
apt upgrade -y;
```


