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
(echo "2"; echo "N"; echo "N"; echo "N"; echo "N";  echo "N"; echo "Y"; echo "N"; echo "N"; echo "Y"; echo "Y"; echo "y"; echo "$PASSWORD_ROOT_SQL") | ./installfog.sh;


#Choice                                                                : 2
#What type of installation would you like to do [N/s (Normal/Storage)] ? N
#Would you like to change the default network interface from ens18     ? N
#Would you like to setup a router address for the DHCP server [Y/n]    ? N
#Would you like DHCP to handle DNS [Y/n]                               ? N
#Would you like to use the FOG server for DHCP service                 ? N
#You like to install the additional language packs                     ? Y
#Would you like to enable secure HTTPS on your FOG server              ? N
#Would you like to change it                                           ? N
#Are you ok with sending this information                              ? Y
#Are you sure you wish to continue                                     ? Y
```

