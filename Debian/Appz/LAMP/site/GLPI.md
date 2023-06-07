--------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
## I. Préparation Environnement
### A. Télécharger GLPI
```bash
clear
VERSION=10.0.7
wget https://github.com/glpi-project/glpi/releases/download/$VERSION/glpi-$VERSION.tgz -O /tmp/glpi.tgz 2>/dev/null;
```

### B. Extraire GLPI
```bash
tar -xf /tmp/glpi.tgz  -C /var/www/html;
```

### C. Permission
```bash
chown -R www-data:www-data /var/www/html;
```

### D. Changer de Distribution (Bookworm)


### E. Modules PHP
Les modules sont pas tous compatibles PHP 8.
```bash
# Indispensable:
apt install -y php-curl php-gd php-intl php-mysqli php-simplexml 1>/dev/null;

# Optionnel:
apt install -y php-bz2 php-ldap php-mbstring php-symfony-polyfill-ctype php-zip 1>/dev/null;
```

### F. Relance du service Apache
```
systemctl restart apache2;
```

### G. Vérification (Prérequis, Sécurité)
```bash
/var/www/html/glpi/bin/console glpi:system:check_requirements;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
## II. Base De Donnée
### A. Purge Database et User
```bash
mysql -u root -padmin -e "DROP DATABASE IF EXISTS GLPI;DROP USER IF EXISTS 'GLPI'@'localhost';"
```

### C. Création de la BDD
La base de donnée se nomme `GLPI`
```bash
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS GLPI;"
```

### D. Création de l'utilisateur
L'identifiant est `GLPI` et le mot de passe est `admin`
```bash
mysql -u root -padmin -e "CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';"
```

### E. Edition des permissions
```bash
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';"
```

### F. Fuseau Horaire
```
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -padmin -u root mysql
# GRANT SELECT ON `mysql`.`time_zone_name` TO 'GLPI'@'localhost';
# FLUSH PRIVILEGES;
mysql -u root -padmin -e "GRANT SELECT ON mysql.time_zone_name TO 'GLPI'@'localhost';"
```

### G. Déconnexion MYSQL
```bash
quit;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
## III. Installation du site
### A. Installation du site
```
clear;
LANGUE=fr_FR
HOST=localhost
DATABSE=GLPI
USERNAMEDB=GLPI
PASSDB=admin

/var/www/html/glpi/bin/console db:install \
--reconfigure \
--default-language=$LANGUE \
--db-host=$HOST \
--db-port=3306 \
--db-name=$DATABSE \
--db-user=$USERNAMEDB \
--db-password=$PASSDB \
--force;
```

--------------------------------------------------------------------------------------------------------------------------------------------
## IV. Configuration du site Apache
#### A. Install.php
Le fichier install.php doit être renommé ou Supprimé
```bash
rm /var/www/html/glpi/install/install.php;
```

#### B. Déplacer config dans Public
```
# Configuration GLPI
mkdir /etc/glpi/;
cp -r /var/www/html/glpi/config /etc/glpi/

# 
mkdir -p /var/lib/glpi/;
cp -r /var/www/html/glpi/files/* /var/lib/glpi/

mkdir -p /var/log/glpi/

echo "<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
   require_once GLPI_CONFIG_DIR . '/local_define.php';
}" > /var/www/html/glpi/inc/downstream.php


echo "<?php
define('GLPI_VAR_DIR', '/var/lib/glpi');
define('GLPI_LOG_DIR', '/var/log/glpi');" > /etc/glpi/local_define.php


echo '<IfModule mod_authz_core.c>
    Require local
</IfModule>
<IfModule !mod_authz_core.c>
    order deny, allow
    deny from all
    allow from 127.0.0.1
    allow from ::1
</IfModule>
ErrorDocument 403 "<p><b>Restricted area.</b><br />Only local access allowed.<br />Check your configuration or contact your administrator.</p>"' > /var/www/html/glpi/install/.htaccess






#### X. Modifier la page par défaut d'Apache
Pour mettre la page index.php en priorité  apache, il faut éditer la configuration du site actif.

La configuration suivante permet de définir index.php en chargement par défaut puis si il y a pas de page index.php de charger index.html.

```bash
nano /etc/apache2/sites-enabled/000-default.conf;
```

```
# Après la ligne DocumentRoot /var/www/html
<IfModule dir_module>
 DirectoryIndex index.php index.html
</IfModule>
```

```
a2enmod rewrite;
systemctl restart apache2;
```

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />







--------------------------------------------------------------------------------------------------------------------------------------------
## IV. AGENT INVENTORY
### Télécharger l'Agent Inventory
```bash
https://github.com/glpi-project/glpi-agent/releases
```

--------------------------------------------------------------------------------------------------------------------------------------------
## VI. Guide d'utilisation
```
Administration > Utilisateurs > <Nom d'utilisateur>
 > Changer les mots de passe des comptes glpi, post-only, tech et normal .
 > Jeton : Identifiant Unique
```
