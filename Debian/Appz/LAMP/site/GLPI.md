--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
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
