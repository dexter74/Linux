---------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation du site phpmyadmin </p>

### A. Dépendances:
```bash
apt install php-mysqli;
```

### B. PHPMyAdmin
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

### C. Autoriser l'authentification mysql_native_password
```bash
clear;
mysql -u root -padmin -e "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"
```
