#### Installation de FOG (Erreur)

```
ERROR 1146 (42S02) at line 1: Table 'fog.globalSettings' doesn't exist
```
```bash
################################
# Script de déploiement de FOG #
################################
#
# Variable d'environnement
FOG=https://github.com/FOGProject/fogproject/archive
RELEASE=1.5.9.tar.gz
PASSWORD_ROOT_SQL=admin

# Nettoyage de la console
clear;

# Dossier TMP
cd /tmp;

# Purge (Silent Mode)
rm -rf /tmp/fogproject* 2>/dev/null;

# Téléchargement
wget $FOG/$RELEASE -O fogproject.tar.gz;

# Extraction du fichier
tar -xf fogproject.tar.gz;

# Déplacement dans le dosssier Fog
cd fogproject-*;

# Remplacement du terme php-gettext en php-php-gettext dans le fichier  /tmp/fogproject-1.5.9/lib/ubuntu/config.sh
sed -i -e "s/php-gettext/php-php-gettext/g" ./lib/ubuntu/config.sh;

# Version de Debian 10 et 11
sed -i -e 's/10)/11)/g' lib/ubuntu/config.sh

# Remplacement de php7.3 en 7.4
sed -i -e's/7.3/7.4/g' lib/ubuntu/config.sh


# Déplacement dans bin
cd bin;

# Lancement de l'installation
(echo "2"; echo "N"; echo "N"; echo "Y"; echo "";  echo "Y"; echo ""; echo "Y"; echo "Y"; echo "n"; echo "n"; echo "y"; echo "$PASSWORD_ROOT_SQL") | ./installfog.sh
```
