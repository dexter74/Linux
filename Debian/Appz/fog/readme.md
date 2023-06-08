----------------------------------------------------------------------------------------------------------------------------
# <p align='center'>Guide d'installation de FOG sur une machine Debian </p>

----------------------------------------------------------------------------------------------------------------------------
#### Guide d'installation via un script FOG
```bash
# Nettoyage de la console
clear;

# Variable d'environnement
FOG=https://github.com/FOGProject/fogproject/archive
RELEASE=1.5.10.tar.gz
PASSWORD_ROOT_SQL=admin

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

# Déplacement dans bin
cd bin;

# Lancement de l'installation
(echo "2"; echo "N"; echo "N"; echo "Y"; echo "";  echo "Y"; echo ""; echo "Y"; echo "Y"; echo "n"; echo "n"; echo "y"; echo "$PASSWORD_ROOT_SQL") | ./installfog.sh;
```
