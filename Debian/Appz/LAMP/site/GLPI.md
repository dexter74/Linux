--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
#### A. Dépôt BookWorm
Les `paquets requis` pour `GLPI` requiert le dépôt `BookWorm` car les modules PHP pour nextcloud sont absent de Bullseye.
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
chown -R www-data:www-data /var/www/html
```

Les extensions suivantes sont installées : fileinfo, json.
Les extensions suivantes sont manquantes : dom, simplexml.
l'extension curl est absente.	
l'extension gd est absente.	
l'extension intl est absente.

### D. Changer de Distribution (Bookworm)


### E. Modules PHP
Les modules sont pas tous compatibles PHP 8.
```bash
apt install -y php-mysqli;
apt install -y php-curl;
apt install -y php-gd;
apt install -y php-intl;
```

### F. Relance du service Apache
```
systemctl restart apache2;
```
