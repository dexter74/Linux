---------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation du site phpmyadmin </p>

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

