--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

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

Les extensions suivantes sont installées : fileinfo, json.
Les extensions suivantes sont manquantes : dom, simplexml.


### D. Changer de Distribution (Bookworm)


### E. Modules PHP
Les modules sont pas tous compatibles PHP 8.
```bash
apt install -y php-bz2;
apt install -y php-curl;
apt install -y php-gd;
apt install -y php-intl;
apt install -y php-ldap;
apt install -y php-mbstring;
apt install -y php-mysqli;
apt install -y php-simplexml;
apt install -y php-symfony-polyfill-ctype;
apt install -y php-zip;
```

### F. Relance du service Apache
```
systemctl restart apache2;
```


### G. Vérification (Prérequis, Sécurité)
```bash
/var/www/html/glpi/bin/console glpi:system:check_requirements;
```
