--------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
## I Préparation Environnement
### A. Télécharger GLPI
```bash
clear
VERSION=10.0.7
wget https://github.com/glpi-project/glpi/releases/download/$VERSION/glpi-$VERSION.tgz -O /tmp/glpi.tgz 2>/dev/null;
```

### B. Extraire GLPI
```bash
cd /tmp/;
tar xvf glpi.tgz -C /var/www/html;
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
apt install -y php-bz2 php-ldap php-mbstring php-symfony-polyfill-ctype php-zip;
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
### Connexion à la Base de Donnée
```bash
mysql -u root -padmin;
```

### Purge Database et User
```bash
DROP DATABASE IF EXISTS GLPI;
DROP USER IF EXISTS 'GLPI'@'localhost';
```

### Création de la BDD
```bash
CREATE DATABASE IF NOT EXISTS GLPI;
```

### Création de l'utilisateur
```bash
CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';
```

### Edition des permissions
```bash
GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';
```

### Fuseau Horaire
```
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -padmin -u root mysql
GRANT SELECT ON `mysql`.`time_zone_name` TO 'GLPI'@'localhost';
FLUSH PRIVILEGES;
```

### Déconnexion MYSQL
```bash
quit;
```
