----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Dépôt
```bash
sed -i -e "s/deb cdrom/#deb cdrom/g"  /etc/apt/sources.list;
```

#### Mettre à jour le Système
```bash
apt update;
apt upgrade -y;
```

#### Installation de paquet
```bash
apt install -y apache2;
apt install -y libapache2-mod-php;
apt install -y mariadb-server;
apt install -y php;
```


#### Installation des modules PHP pour GLPI
```bash
apt install -y apcupsd;
apt install -y php-apcu;
apt install -y php-bz2;
apt install -y php-cas;
apt install -y php-curl;
apt install -y php-dom;
apt install -y php-gd;
apt install -y php-imap;
apt install -y php-ldap;
apt install -y php-intl;
apt install -y php-json;
apt install -y php-mbstring;
apt install -y php-mysql;
apt install -y php-fileinfo;
apt install -y php-simplexml;
apt install -y php-xmlrpc;
apt install -y php-zip;
```


#### Sécuriser la Base De Donnée
```bash
PASSWORD_DB=admin
(echo ""; echo "y" ; echo "y"; echo "$PASSWORD_DB"; echo "$PASSWORD_DB"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```
#### Connexion à la Base de Donnée
```bash
mysql -u root -padmin;
```

#### Purge Database et User
```bash
DROP DATABASE IF EXISTS GLPI;
DROP USER IF EXISTS 'GLPI'@'localhost';
```

#### Création de la BDD
```bash
CREATE DATABASE IF NOT EXISTS GLPI;
```

#### Création de l'utilisateur
```bash
CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';
```

### Edition des permissions
```bash
GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';
```

#### Déconnexion MYSQL
```bash
quit;
```

#### GLPI 9.5.X
```bash
FILE="https://github.com/glpi-project/glpi/releases/download/9.5.12/glpi-9.5.12.tgz"
rm -r /var/www/html/glpi 2>/dev/null;
wget "$FILE"  -O /tmp/glpi-9.5.12.tgz;
tar -xvf /tmp/glpi-9.5.12.tgz -C /var/www/html;
```

#### GLPI 10.0.6
```bash
FILE="https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz"

wget "$FILE" -O /tmp/glpi-10.0.6.tgz;
rm -r /var/www/html/glpi 2>/dev/null;
tar -xvf  /tmp/glpi-10.0.6.tgz -C /var/www/html;
```

### Permission www
```bash
chown -R www-data:www-data /var/www/html/;
```

### Relancer le Service Apache2
Apache charge PHP et ses modules
```bash
systemctl restart apache2;
```

#### Installation du site
```bash
cd /var/www/html/glpi;
php bin/console glpi:system:check_requirements;

php bin/console db:install --reconfigure \
--default-language=fr_FR \
--db-host=localhost \
--db-port=3306 \
--db-name=GLPI \
--db-user=GLPI \
--db-password=admin \
--force;
```

#### Divers Commande [ICI](https://glpi-install.readthedocs.io/fr/develop/command-line.html#cdline-install)
```
cd /var/www/html/glpi;
php bin/console db:check;
php bin/console glpi:migration:timestamps;

php bin/console glpi:maintenance:enable;
php bin/console glpi:maintenance:disable;
php bin/console db:update -f;
```


#### Sécurité
Le fichier install.php doit être renommé ou Supprimé
```bash
mv /var/www/html/glpi/install/install.php     /var/www/html/glpi/install/install.php.old;
rm /var/www/html/glpi/install/install.php.old;
```

#### Gestionnaire de Base De Donnée (phpmyadmin
```bash
apt upgrade -y php-tcpdf php-twig;
apt install -y -t buster-backports php-twig;

wget "https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip" -O  /tmp/phpMyAdmin.zip;
unzip /tmp/phpMyAdmin.zip -d /var/www/html;
mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpmyadmin;
```
